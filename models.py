from datetime import datetime
from database import db


class Destination(db.Model):
    """OOP class representing a travel destination"""
    __tablename__ = 'destinations'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    country = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    image_url = db.Column(db.String(500))
    category = db.Column(db.String(50))
    rating = db.Column(db.Float, default=0.0)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    packages = db.relationship('Package', backref='destination', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Destination {self.name}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'country': self.country,
            'description': self.description,
            'image_url': self.image_url,
            'category': self.category,
            'rating': self.rating
        }


class Package(db.Model):
    """OOP class representing a tour package"""
    __tablename__ = 'packages'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200), nullable=False)
    destination_id = db.Column(db.Integer, db.ForeignKey('destinations.id'), nullable=False)
    description = db.Column(db.Text, nullable=False)
    duration_days = db.Column(db.Integer, nullable=False)
    price = db.Column(db.Float, nullable=False)
    max_travelers = db.Column(db.Integer, default=20)
    includes = db.Column(db.Text)
    image_url = db.Column(db.String(500))
    is_featured = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    bookings = db.relationship('Booking', backref='package', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Package {self.name}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'destination': self.destination.name if self.destination else None,
            'description': self.description,
            'duration_days': self.duration_days,
            'price': self.price,
            'max_travelers': self.max_travelers,
            'includes': self.includes,
            'image_url': self.image_url,
            'is_featured': self.is_featured
        }


class Customer(db.Model):
    """OOP class representing a customer"""
    __tablename__ = 'customers'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    phone = db.Column(db.String(20))
    address = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    bookings = db.relationship('Booking', backref='customer', lazy=True, cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Customer {self.name}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'phone': self.phone,
            'address': self.address
        }


class Booking(db.Model):
    """OOP class representing a booking"""
    __tablename__ = 'bookings'
    
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customers.id'), nullable=False)
    package_id = db.Column(db.Integer, db.ForeignKey('packages.id'), nullable=False)
    travel_date = db.Column(db.Date, nullable=False)
    num_travelers = db.Column(db.Integer, default=1)
    total_price = db.Column(db.Float, nullable=False)
    status = db.Column(db.String(20), default='pending')
    special_requests = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    def __repr__(self):
        return f'<Booking {self.id}>'
    
    def to_dict(self):
        return {
            'id': self.id,
            'customer': self.customer.name if self.customer else None,
            'package': self.package.name if self.package else None,
            'travel_date': self.travel_date.isoformat() if self.travel_date else None,
            'num_travelers': self.num_travelers,
            'total_price': self.total_price,
            'status': self.status,
            'special_requests': self.special_requests
        }
