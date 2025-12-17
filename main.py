import os
from datetime import datetime
from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from werkzeug.utils import secure_filename
import base64
import time
from database import db, init_db
from models import Destination, Package, Customer, Booking

app = Flask(__name__)
app.secret_key = os.environ.get("SESSION_SECRET") or "travel-tourism-secret-key"

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:@localhost/voyage_portal'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# Upload settings
UPLOAD_FOLDER = os.path.join(app.root_path, 'static', 'uploads')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

# Ensure upload folder exists and a default image is present
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
default_path = os.path.join(app.config['UPLOAD_FOLDER'], 'default.png')
if not os.path.exists(default_path):
    # tiny 1x1 PNG placeholder
    png_base64 = (
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII='
    )
    with open(default_path, 'wb') as f:
        f.write(base64.b64decode(png_base64))

init_db(app)

with app.app_context():
    db.create_all()


@app.route('/')
def index():
    """Home page with featured destinations and packages"""
    featured_destinations = Destination.query.limit(6).all()
    featured_packages = Package.query.filter_by(is_featured=True).limit(4).all()
    return render_template('index.html', 
                         destinations=featured_destinations, 
                         packages=featured_packages,
                         get_image=get_destination_image)


@app.route('/destinations')
def destinations():
    """Browse all destinations with search and filter"""
    search = request.args.get('search', '')
    category = request.args.get('category', '')
    
    query = Destination.query
    
    if search:
        query = query.filter(
            (Destination.name.ilike(f'%{search}%')) | 
            (Destination.country.ilike(f'%{search}%'))
        )
    
    if category:
        query = query.filter_by(category=category)
    
    all_destinations = query.all()
    categories = db.session.query(Destination.category).distinct().all()
    categories = [c[0] for c in categories if c[0]]
    
    return render_template('destinations.html', 
                         destinations=all_destinations,
                         categories=categories,
                         current_search=search,
                         current_category=category,
                         get_image=get_destination_image)


SAMPLE_DESTINATIONS = [
    {"name": "Goa", "type": "Beach", "price": 12000},
    {"name": "Ooty", "type": "Hill Station", "price": 9000},
    {"name": "Delhi", "type": "Historical", "price": 8000}
]


@app.route('/api/destinations')
def api_destinations():
    """Return destinations as JSON; fall back to sample list if DB empty"""
    dests = Destination.query.all()
    if dests:
        return jsonify([d.to_dict() for d in dests])
    return jsonify(SAMPLE_DESTINATIONS)


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


def get_destination_image(image_url):
    """Return a usable image URL for a destination (external or uploaded)."""
    if image_url:
        if str(image_url).startswith('http'):
            return image_url
        return url_for('static', filename=f'uploads/{image_url}')
    return url_for('static', filename='uploads/default.png')


@app.route('/add-destination', methods=['GET', 'POST'])
def add_destination():
    if request.method == 'POST':
        name = request.form.get('name')
        country = request.form.get('country') or request.form.get('location') or 'Unknown'
        description = request.form.get('description', '')
        category = request.form.get('category')
        rating = float(request.form.get('rating') or 0)

        image_file = request.files.get('image')
        filename = None
        if image_file and image_file.filename and allowed_file(image_file.filename):
            filename = secure_filename(image_file.filename)
            # prefix with timestamp to avoid collisions
            filename = f"{int(time.time())}_{filename}"
            save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            image_file.save(save_path)

        dest = Destination(
            name=name,
            country=country,
            description=description,
            image_url=filename,
            category=category,
            rating=rating
        )
        db.session.add(dest)
        db.session.commit()
        flash("Destination added successfully!", 'success')
        return redirect(url_for('destinations'))

    return render_template('add_destination.html')


@app.route('/destination/<int:id>')
def destination_detail(id):
    """View destination details and its packages"""
    destination = Destination.query.get_or_404(id)
    return render_template('destination_detail.html', destination=destination, image_url=get_destination_image(destination.image_url))


@app.route('/packages')
def packages():
    """Browse all tour packages"""
    min_price = request.args.get('min_price', type=float)
    max_price = request.args.get('max_price', type=float)
    duration = request.args.get('duration', type=int)
    
    query = Package.query
    
    if min_price:
        query = query.filter(Package.price >= min_price)
    if max_price:
        query = query.filter(Package.price <= max_price)
    if duration:
        query = query.filter(Package.duration_days == duration)
    
    all_packages = query.all()
    return render_template('packages.html', packages=all_packages)


@app.route('/package/<int:id>')
def package_detail(id):
    """View package details"""
    package = Package.query.get_or_404(id)
    return render_template('package_detail.html', package=package)


@app.route('/book/<int:package_id>', methods=['GET', 'POST'])
def book_package(package_id):
    """Book a tour package"""
    package = Package.query.get_or_404(package_id)
    
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        travel_date = request.form.get('travel_date')
        num_travelers = int(request.form.get('num_travelers', 1))
        special_requests = request.form.get('special_requests', '')
        
        customer = Customer.query.filter_by(email=email).first()
        if not customer:
            customer = Customer(name=name, email=email, phone=phone)
            db.session.add(customer)
            db.session.flush()
        
        total_price = package.price * num_travelers
        
        booking = Booking(
            customer_id=customer.id,
            package_id=package.id,
            travel_date=datetime.strptime(travel_date, '%Y-%m-%d').date(),
            num_travelers=num_travelers,
            total_price=total_price,
            special_requests=special_requests,
            status='pending'
        )
        
        db.session.add(booking)
        db.session.commit()
        
        flash(f'Booking confirmed! Your booking ID is #{booking.id}. Total: ${total_price:.2f}', 'success')
        return redirect(url_for('booking_confirmation', booking_id=booking.id))
    
    return render_template('book.html', package=package)


@app.route('/booking/<int:booking_id>')
def booking_confirmation(booking_id):
    """Booking confirmation page"""
    booking = Booking.query.get_or_404(booking_id)
    return render_template('booking_confirmation.html', booking=booking)


@app.route('/about')
def about():
    """About us page"""
    return render_template('about.html')


@app.route('/contact', methods=['GET', 'POST'])
def contact():
    """Contact page"""
    if request.method == 'POST':
        flash('Thank you for your message! We will get back to you soon.', 'success')
        return redirect(url_for('contact'))
    return render_template('contact.html')


@app.route('/admin')
def admin_dashboard():
    """Admin dashboard"""
    stats = {
        'destinations': Destination.query.count(),
        'packages': Package.query.count(),
        'bookings': Booking.query.count(),
        'customers': Customer.query.count()
    }
    recent_bookings = Booking.query.order_by(Booking.created_at.desc()).limit(5).all()
    return render_template('admin/dashboard.html', stats=stats, recent_bookings=recent_bookings)


@app.route('/admin/destinations')
def admin_destinations():
    """Manage destinations"""
    destinations = Destination.query.all()
    return render_template('admin/destinations.html', destinations=destinations)


@app.route('/admin/destination/add', methods=['GET', 'POST'])
def admin_add_destination():
    """Add new destination"""
    if request.method == 'POST':
        destination = Destination(
            name=request.form.get('name'),
            country=request.form.get('country'),
            description=request.form.get('description'),
            image_url=request.form.get('image_url'),
            category=request.form.get('category'),
            rating=float(request.form.get('rating', 0))
        )
        db.session.add(destination)
        db.session.commit()
        flash('Destination added successfully!', 'success')
        return redirect(url_for('admin_destinations'))
    
    return render_template('admin/destination_form.html', destination=None)


@app.route('/admin/destination/edit/<int:id>', methods=['GET', 'POST'])
def admin_edit_destination(id):
    """Edit destination"""
    destination = Destination.query.get_or_404(id)
    
    if request.method == 'POST':
        destination.name = request.form.get('name')
        destination.country = request.form.get('country')
        destination.description = request.form.get('description')
        destination.image_url = request.form.get('image_url')
        destination.category = request.form.get('category')
        destination.rating = float(request.form.get('rating', 0))
        db.session.commit()
        flash('Destination updated successfully!', 'success')
        return redirect(url_for('admin_destinations'))
    
    return render_template('admin/destination_form.html', destination=destination)


@app.route('/admin/destination/delete/<int:id>')
def admin_delete_destination(id):
    """Delete destination"""
    destination = Destination.query.get_or_404(id)
    db.session.delete(destination)
    db.session.commit()
    flash('Destination deleted successfully!', 'success')
    return redirect(url_for('admin_destinations'))


@app.route('/admin/packages')
def admin_packages():
    """Manage packages"""
    packages = Package.query.all()
    return render_template('admin/packages.html', packages=packages)


@app.route('/admin/package/add', methods=['GET', 'POST'])
def admin_add_package():
    """Add new package"""
    if request.method == 'POST':
        package = Package(
            name=request.form.get('name'),
            destination_id=int(request.form.get('destination_id')),
            description=request.form.get('description'),
            duration_days=int(request.form.get('duration_days')),
            price=float(request.form.get('price')),
            max_travelers=int(request.form.get('max_travelers', 20)),
            includes=request.form.get('includes'),
            image_url=request.form.get('image_url'),
            is_featured=bool(request.form.get('is_featured'))
        )
        db.session.add(package)
        db.session.commit()
        flash('Package added successfully!', 'success')
        return redirect(url_for('admin_packages'))
    
    destinations = Destination.query.all()
    return render_template('admin/package_form.html', package=None, destinations=destinations)


@app.route('/admin/package/edit/<int:id>', methods=['GET', 'POST'])
def admin_edit_package(id):
    """Edit package"""
    package = Package.query.get_or_404(id)
    
    if request.method == 'POST':
        package.name = request.form.get('name')
        package.destination_id = int(request.form.get('destination_id'))
        package.description = request.form.get('description')
        package.duration_days = int(request.form.get('duration_days'))
        package.price = float(request.form.get('price'))
        package.max_travelers = int(request.form.get('max_travelers', 20))
        package.includes = request.form.get('includes')
        package.image_url = request.form.get('image_url')
        package.is_featured = bool(request.form.get('is_featured'))
        db.session.commit()
        flash('Package updated successfully!', 'success')
        return redirect(url_for('admin_packages'))
    
    destinations = Destination.query.all()
    return render_template('admin/package_form.html', package=package, destinations=destinations)


@app.route('/admin/package/delete/<int:id>')
def admin_delete_package(id):
    """Delete package"""
    package = Package.query.get_or_404(id)
    db.session.delete(package)
    db.session.commit()
    flash('Package deleted successfully!', 'success')
    return redirect(url_for('admin_packages'))


@app.route('/admin/bookings')
def admin_bookings():
    """Manage bookings"""
    bookings = Booking.query.order_by(Booking.created_at.desc()).all()
    return render_template('admin/bookings.html', bookings=bookings)


@app.route('/admin/booking/status/<int:id>/<status>')
def admin_update_booking_status(id, status):
    """Update booking status"""
    booking = Booking.query.get_or_404(id)
    if status in ['pending', 'confirmed', 'cancelled']:
        booking.status = status
        db.session.commit()
        flash(f'Booking status updated to {status}!', 'success')
    return redirect(url_for('admin_bookings'))


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
