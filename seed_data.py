"""Seed script to populate database with sample travel data"""
import os
from flask import Flask
from database import db, init_db
from models import Destination, Package

def create_app():
    app = Flask(__name__)
    app.secret_key = os.environ.get("SESSION_SECRET") or "travel-tourism-secret-key"
    init_db(app)
    return app

def seed_database():
    app = create_app()
    with app.app_context():
        db.create_all()
        
        if Destination.query.count() > 0:
            print("Database already has data. Skipping seed.")
            return
        
        destinations = [
            Destination(
                name="Bali",
                country="Indonesia",
                description="Bali is a tropical paradise known for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs. The island is home to religious sites such as cliffside Uluwatu Temple. Experience the perfect blend of adventure, relaxation, and cultural immersion in this Indonesian gem.",
                image_url="https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800",
                category="Beach",
                rating=4.8
            ),
            Destination(
                name="Paris",
                country="France",
                description="Paris, the City of Light, is renowned worldwide for its stunning architecture, art museums, and romantic atmosphere. From the iconic Eiffel Tower to the world-famous Louvre Museum, Paris offers an unforgettable experience for travelers seeking culture, cuisine, and charm.",
                image_url="https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800",
                category="City",
                rating=4.9
            ),
            Destination(
                name="Swiss Alps",
                country="Switzerland",
                description="The Swiss Alps offer breathtaking mountain scenery, world-class skiing, and charming alpine villages. Experience the majesty of snow-capped peaks, pristine lakes, and some of the most stunning natural landscapes in Europe.",
                image_url="https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800",
                category="Mountain",
                rating=4.7
            ),
            Destination(
                name="Machu Picchu",
                country="Peru",
                description="Machu Picchu is an ancient Incan citadel set high in the Andes Mountains. This UNESCO World Heritage site is a testament to the engineering genius of the Inca civilization. Trek through the Sacred Valley and witness one of the New Seven Wonders of the World.",
                image_url="https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800",
                category="Adventure",
                rating=4.9
            ),
            Destination(
                name="Tokyo",
                country="Japan",
                description="Tokyo is a city of contrasts, where ancient temples stand alongside futuristic skyscrapers. Experience cutting-edge technology, traditional culture, world-class cuisine, and the unique energy of one of the world's most vibrant cities.",
                image_url="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800",
                category="City",
                rating=4.8
            ),
            Destination(
                name="Serengeti",
                country="Tanzania",
                description="The Serengeti National Park is one of the most famous safari destinations in the world. Witness the Great Migration, spot the Big Five, and experience the raw beauty of African wildlife in their natural habitat.",
                image_url="https://images.unsplash.com/photo-1516426122078-c23e76319801?w=800",
                category="Wildlife",
                rating=4.9
            )
        ]
        
        for dest in destinations:
            db.session.add(dest)
        
        db.session.commit()
        print(f"Added {len(destinations)} destinations")
        
        packages = [
            Package(
                name="Bali Beach Paradise",
                destination_id=1,
                description="Explore the best of Bali with this comprehensive package. Visit ancient temples, relax on pristine beaches, and immerse yourself in Balinese culture.",
                duration_days=7,
                price=1299,
                max_travelers=12,
                includes="5-star resort accommodation\nDaily breakfast and dinner\nAirport transfers\nTemple tours\nRice terrace visit\nSnorkeling trip\nProfessional guide",
                image_url="https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800",
                is_featured=True
            ),
            Package(
                name="Romantic Paris Getaway",
                destination_id=2,
                description="Experience the romance of Paris with this exclusive package. Visit iconic landmarks, enjoy gourmet cuisine, and create unforgettable memories.",
                duration_days=5,
                price=1899,
                max_travelers=8,
                includes="Boutique hotel in central Paris\nEiffel Tower skip-the-line tickets\nLouvre Museum tour\nSeine River cruise\nDaily breakfast\nAirport transfers\nWine tasting experience",
                image_url="https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800",
                is_featured=True
            ),
            Package(
                name="Swiss Alps Adventure",
                destination_id=3,
                description="Discover the majestic Swiss Alps with hiking, skiing, and breathtaking mountain views. Perfect for adventure seekers and nature lovers.",
                duration_days=6,
                price=2199,
                max_travelers=10,
                includes="Mountain lodge accommodation\nAll meals included\nGuided hiking tours\nCable car passes\nSki equipment rental\nSwiss rail pass\nProfessional mountain guide",
                image_url="https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800",
                is_featured=True
            ),
            Package(
                name="Machu Picchu Trek",
                destination_id=4,
                description="Embark on the adventure of a lifetime with this Inca Trail trekking package. Experience ancient ruins, stunning landscapes, and rich history.",
                duration_days=8,
                price=1799,
                max_travelers=15,
                includes="Camping equipment\nAll meals during trek\nInca Trail permits\nProfessional guide and porters\nHotel in Cusco\nMachu Picchu entrance\nTrain tickets",
                image_url="https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800",
                is_featured=True
            ),
            Package(
                name="Tokyo Cultural Experience",
                destination_id=5,
                description="Immerse yourself in Japanese culture with this Tokyo-centric package. From ancient temples to modern technology, experience the best of Japan.",
                duration_days=7,
                price=2499,
                max_travelers=10,
                includes="4-star hotel accommodation\nJapan Rail Pass\nTea ceremony experience\nTemple and shrine tours\nSumo wrestling viewing\nDaily breakfast\nEnglish-speaking guide",
                image_url="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=800",
                is_featured=False
            ),
            Package(
                name="Serengeti Safari Adventure",
                destination_id=6,
                description="Witness the incredible wildlife of Africa on this unforgettable safari adventure. See lions, elephants, and the Great Migration up close.",
                duration_days=6,
                price=3299,
                max_travelers=8,
                includes="Luxury safari lodge\nAll meals and drinks\nDaily game drives\nPark entrance fees\nProfessional safari guide\nAirport transfers\nBush dinner experience",
                image_url="https://images.unsplash.com/photo-1516426122078-c23e76319801?w=800",
                is_featured=False
            )
        ]
        
        for pkg in packages:
            db.session.add(pkg)
        
        db.session.commit()
        print(f"Added {len(packages)} packages")
        print("Database seeded successfully!")

if __name__ == '__main__':
    seed_database()
