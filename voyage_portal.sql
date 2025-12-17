-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2025 at 01:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `voyage_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `travel_date` date NOT NULL,
  `num_travelers` int(11) DEFAULT NULL,
  `total_price` float NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `special_requests` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `customer_id`, `package_id`, `travel_date`, `num_travelers`, `total_price`, `status`, `special_requests`, `created_at`) VALUES
(1, 1, 16, '2025-12-21', 1, 120000, 'pending', 'nil', '2025-12-15 07:07:21');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`, `created_at`) VALUES
(1, 'V SRIDEVI', 'sridevivenkatesan1970@gmail.com', '9025900081', NULL, '2025-12-15 07:07:21');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `budget_range` enum('Low','Medium','High') DEFAULT 'Medium',
  `is_featured` tinyint(1) DEFAULT 0,
  `best_time_to_visit` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`id`, `name`, `country`, `description`, `category`, `rating`, `created_at`, `image_url`, `budget_range`, `is_featured`, `best_time_to_visit`) VALUES
(332, 'Goa', 'India', 'Goa is one of India’s most popular tourist destinations, famous for its beautiful sandy beaches, vibrant nightlife, and relaxed coastal lifestyle. Located along the Arabian Sea, Goa attracts visitors with its lively beach shacks, music festivals, night clubs, and beach parties, especially in areas like Baga, Calangute, and Anjuna.\r\n\r\nApart from nightlife, Goa offers a rich blend of Portuguese heritage, seen in its old churches, colorful houses, and historic forts. Tourists can enjoy water sports such as parasailing, jet skiing, and scuba diving, or simply relax by the sea. With delicious seafood, scenic sunsets, and a welcoming atmosphere, Goa is an ideal destination for both adventure seekers and leisure travelers.', 'Beach  Nightlife  Leisure', 4.5, '2025-12-14 16:32:53', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEh3V8nizyM0LhnIFpppx7ClFjNXAeLRUfYQ&s', 'Medium', 1, '✅ November to February\r\nReason:\r\n1.Pleasant weather\r\n2.Ideal for beaches and nightlife\r\n3.Best time '),
(333, 'Ooty', 'India', 'Ooty is a peaceful hill station famous for its lush green tea gardens, cool climate, and scenic mountain views. It is an ideal destination for nature lovers, offering calm surroundings, botanical gardens, and beautiful lakes, making it perfect for relaxation and family trips.', 'Hill Station', 4.6, '2025-12-14 16:32:53', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzmaS-fQY5Shg2I37stExRNw7A6DU74Yyv6g&s', 'Medium', 1, '🌸 March to June – Pleasant summer climate\r\n❄️ October to February – Cool winter & sightseeing\r\n🌤️ Th'),
(334, 'Manali', 'India', 'Manali is a charming hill station located in Himachal Pradesh, surrounded by snow-capped mountains, pine forests, and scenic valleys. Its cool climate, fresh air, and breathtaking views make it a favorite destination for nature lovers and families looking for a peaceful getaway.\r\n\r\nThe town is also famous for adventure and leisure activities such as trekking, skiing, paragliding, river rafting, and sightseeing. Popular attractions like Solang Valley, Rohtang Pass, and Hadimba Temple make Manali an ideal place for both relaxation and thrilling experiences.', 'Hill Station', 4.7, '2025-12-14 16:32:53', 'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcRYwRSVPzp0NCB8z7aQ9uFJTO-IIyBTaARQwgUkkl-aUenAhdGCWXrmcnt4nPClZ2F3ZQLQmr4-ahcgkVPcK70_gOU&s=19', 'Medium', 1, '🌸 Best time to visit:\r\n\r\nMarch to June – Pleasant weather 🌞\r\n\r\nOctober to February – Snow & winter f'),
(335, 'Jaipur', 'India', 'Jaipur, the capital city of Rajasthan, is famously known as the Pink City due to its beautifully colored historic buildings. The city is rich in royal heritage, grand palaces, ancient forts, and vibrant culture, reflecting the glorious history of the Rajput kings and their architectural brilliance.\r\n\r\n\r\nJaipur is also a major tourist destination known for attractions like Amber Fort, Hawa Mahal, City Palace, and Jantar Mantar. Along with its monuments, the city offers colorful bazaars, traditional Rajasthani cuisine, folk music, and festivals, making it a perfect blend of history, culture, and modern tourism.', 'Heritage', 4.4, '2025-12-14 16:32:53', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSxWAPbQYrd_lqADsbEvZjZtrTD6VrA2KNUJkDODvjuvpNik0vG1LggYB4PgT_5dljGdjcItPUzlwsm27cmtyqFZJz7QQDMqZT2Uex7BSc1LUOUWE2TQpVLmG2ZgZ5BAgZA37dAbbA=w763-h441-n-k-no', 'Medium', 0, '🌸 Best time to visit:\r\nOctober to March – Pleasant weather for sightseeing 🌤️'),
(336, 'Pondicherry', 'India', 'Pondicherry, also known as Puducherry, is a charming coastal town on the southeast coast of India, famous for its French colonial architecture, peaceful beaches, and relaxed atmosphere. The town’s clean streets, colorful buildings, and seaside promenade give it a unique blend of Indian culture and French heritage.\r\n\r\nPondicherry is ideal for travelers seeking calm and spirituality, with attractions like Auroville, Sri Aurobindo Ashram, and scenic beaches such as Promenade Beach and Paradise Beach. Its cafés, spiritual centers, and cultural experiences make Pondicherry a perfect destination for leisure and reflection.', 'Beach', 4.3, '2025-12-14 16:32:53', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSzjWvzZCGYjmau6JhzEk74d-5c9NLCbSEEy2KUxsSz4Apa7caHUUQtUayY4D_uQsAmAP9kJYhPcN8XI5waqze1GriSidw8888uFXQ6xM9Vd_Tf28M4KnId_bG3Dmgn8-yN8CyFs=w763-h441-n-k-no', 'Low', 0, '🌸 Best time to visit:\r\nOctober to March – Pleasant weather and ideal for beach activities 🌤️🌊'),
(337, 'Paris', 'France', 'Paris, the capital city of France, is one of the most romantic and culturally rich cities in the world. Known as the City of Light, Paris is famous for its iconic landmarks, elegant architecture, world-class museums, and vibrant street life along the River Seine.\r\n\r\nThe city attracts millions of visitors with attractions such as the Eiffel Tower, Louvre Museum, Notre-Dame Cathedral, and Champs-Élysées. Paris is also celebrated for its fashion, art, cuisine, and cafés, making it a perfect destination for couples, history lovers, and culture enthusiasts.', 'International', 4.8, '2025-12-14 16:32:53', 'https://static.independent.co.uk/2025/04/25/13/42/iStock-1498516775.jpg', 'High', 1, '🌸 Best time to visit:\r\nApril to June & September to October – Mild weather and fewer crowds 🌷🍂'),
(338, 'Dubai', 'UAE', 'Dubai is a modern and luxurious city in the United Arab Emirates, famous for its futuristic skyline, world-class shopping, and iconic landmarks. The city blends traditional Arabian culture with cutting-edge architecture, offering experiences ranging from historic souks to towering skyscrapers.\r\n\r\nDubai is known for attractions such as the Burj Khalifa, Palm Jumeirah, Dubai Mall, and desert safaris. Visitors can enjoy luxury resorts, adventure activities, vibrant nightlife, and rich cultural experiences, making Dubai a top global destination for tourism and business.', 'International', 4.6, '2025-12-14 16:32:53', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSzRb--rTYqMPxxPXg671G8EvcrF7HadT8aULnrC3IjluXMSmy8v-vzeq671EIUFha6sjjHABKpOTaXaR2TGF3eE1kKAbkDs64SxbPZo1ISSxPkvwWWCGalyxG2VeoVWiVUALLzkNg=w763-h441-n-k-no', 'High', 1, '🌸 Best time to visit:\r\nNovember to March – Pleasant winter climate for sightseeing and outdoor activ'),
(339, 'Singapore', 'Singapore', 'Singapore is a modern island city-state in Southeast Asia, known for its cleanliness, advanced infrastructure, and multicultural heritage. The city blends futuristic architecture with lush green spaces, offering a perfect balance between urban life and nature.\r\n\r\nSingapore is famous for attractions such as Marina Bay Sands, Gardens by the Bay, Sentosa Island, and Universal Studios. Its diverse food culture, safe environment, efficient transport system, and vibrant nightlife make Singapore a top destination for tourists from around the world.', 'International', 4.8, '2025-12-14 16:32:53', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKGYPeIi_NYAe586B3iBSx1n0u1m5K0rtEqw&s', 'Medium', 1, '🌸 Best time to visit:\r\nFebruary to April – Pleasant weather and fewer rain showers 🌤️🌿'),
(340, 'Bali', 'Indonesia', 'Bali is a beautiful Indonesian island known for its tropical beaches, lush rice terraces, and rich cultural heritage. The island is famous for its temples, traditional dance, and peaceful atmosphere, making it a favorite destination for nature lovers and spiritual travelers.\r\n\r\nBali offers a wide range of experiences, from surfing and snorkeling to yoga retreats and cultural tours. Popular attractions like Ubud, Tanah Lot Temple, and Kuta Beach make Bali an ideal destination for relaxation, adventure, and cultural exploration.', 'International', 5, '2025-12-14 16:32:53', 'https://res.klook.com/image/upload/fl_lossy.progressive,q_60/Mobile/City/olvu6sgb3dcdjwlcpts3.jpg', 'Low', 1, '🌸 Best time to visit:\r\nApril to October – Dry season with pleasant weather 🌞🌊'),
(341, 'Maldives', 'Maldives', 'Maldives is a stunning island nation in the Indian Ocean, famous for its crystal-clear waters, white sandy beaches, and luxury overwater villas. The islands offer breathtaking views, vibrant marine life, and a calm atmosphere, making it one of the most popular honeymoon and relaxation destinations in the world.\r\n\r\nThe Maldives is ideal for activities such as snorkeling, scuba diving, island hopping, and sunset cruises. With its turquoise lagoons, coral reefs, and world-class resorts, the Maldives provides a perfect escape for travelers seeking peace, romance, and natural beauty.', 'International', 4.5, '2025-12-14 16:32:53', 'https://afar.brightspotcdn.com/dims4/default/ea28eda/2147483647/strip/false/crop/3000x1688+0+275/resize/1200x675!/quality/90/?url=https%3A%2F%2Fk3-prod-afar-media.s3.us-west-2.amazonaws.com%2Fbrightspot%2Fb2%2Ff4%2F9a1ebe3f427f8e5eb937f8df8998%2Ftravelguides-maldives-videomediastudioeurope-shutterstock.jpg', 'High', 1, '🌸 Best time to visit:\r\nNovember to April – Dry season with clear skies and calm seas ☀️🌊');

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `destination_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `duration_days` int(11) NOT NULL,
  `price` float NOT NULL,
  `max_travelers` int(11) DEFAULT NULL,
  `includes` text DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `destination_id`, `description`, `duration_days`, `price`, `max_travelers`, `includes`, `image_url`, `is_featured`, `created_at`) VALUES
(7, 'Goa Beach Holiday', 332, 'Goa is one of India’s most popular beach destinations, known for its golden sandy beaches, lively nightlife, and relaxed coastal vibe. With a mix of Portuguese heritage, scenic coastline, and tropical weather, Goa offers the perfect escape for travelers looking to unwind and have fun.\r\n\r\nThe destination is famous for beach activities, water sports, historic churches, vibrant markets, and beach shacks. Whether you want adventure, parties, or peaceful sunsets by the sea, Goa caters to families, friends, and couples alike.', 4, 15000, 20, 'Hotel Stay, Breakfast, Airport Transfer, Beach Activities, Sightseeing\r\n', 'https://hblimg.mmtcdn.com/content/hubble/img/goakolkatadestimages/mmt/activities/m_Goa_3_l_666_1000.jpg', 1, '2025-12-15 12:36:01'),
(8, 'Ooty Nature Escape', 333, 'Ooty, also known as Udhagamandalam, is a beautiful hill station located in the Nilgiri Hills of Tamil Nadu. Known for its cool climate, misty mountains, tea plantations, and lush green landscapes, Ooty is a perfect destination for nature lovers and those seeking a peaceful retreat.\r\n\r\nThe town offers relaxing experiences such as boating in Ooty Lake, visiting botanical gardens, exploring tea estates, and enjoying scenic views from Doddabetta Peak. With its calm atmosphere and pleasant weather throughout the year, Ooty is ideal for families, couples, and leisure travelers.', 3, 9000, 15, 'Hotel Stay, Breakfast, Sightseeing, Tea Garden Visit, Local Transfer\r\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzmaS-fQY5Shg2I37stExRNw7A6DU74Yyv6g&s', 0, '2025-12-15 12:36:01'),
(9, 'Manali Snow Adventure', 334, 'Snow activities, mountains, and adventure sports', 5, 18000, 18, 'Hotel, Meals, Snow Point Visit', 'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcRYwRSVPzp0NCB8z7aQ9uFJTO-IIyBTaARQwgUkkl-aUenAhdGCWXrmcnt4nPClZ2F3ZQLQmr4-ahcgkVPcK70_gOU&s=19', 1, '2025-12-15 12:36:01'),
(10, 'Jaipur Royal Heritage Tour', 335, 'Jaipur, the capital of Rajasthan, is famously known as the Pink City for its beautiful rose-colored buildings and rich royal heritage. The city is known for its grand forts, palaces, and vibrant culture that reflect the glorious history of the Rajput kings.\r\n\r\nJaipur offers memorable experiences through attractions such as Amber Fort, Hawa Mahal, City Palace, and Jantar Mantar. Along with historical sites, visitors can enjoy colorful bazaars, traditional Rajasthani cuisine, folk music, and cultural performances, making Jaipur a perfect blend of history and tradition.', 3, 11000, 20, 'Hotel Stay, Breakfast, Airport Transfer, City Sightseeing, Fort Visit\r\n', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSxWAPbQYrd_lqADsbEvZjZtrTD6VrA2KNUJkDODvjuvpNik0vG1LggYB4PgT_5dljGdjcItPUzlwsm27cmtyqFZJz7QQDMqZT2Uex7BSc1LUOUWE2TQpVLmG2ZgZ5BAgZA37dAbbA=w763-h441-n-k-no', 0, '2025-12-15 12:36:01'),
(11, 'Pondicherry Coastal Bliss', 336, 'Pondicherry, also known as Puducherry, is a charming coastal town famous for its French colonial architecture, peaceful beaches, and relaxed atmosphere. The town’s colorful streets, seaside promenade, and calm environment make it a unique destination that blends Indian culture with European influence.\r\n\r\nPondicherry is ideal for travelers seeking peace and spirituality, with attractions like Sri Aurobindo Ashram, Auroville, and scenic beaches such as Promenade Beach and Paradise Beach. Its cafés, spiritual centers, and coastal beauty make Pondicherry a perfect getaway for leisure and reflection.', 3, 10000, 15, 'Hotel Stay, Breakfast, Beach Visit, Auroville Tour, Local Transfer\r\n', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSzjWvzZCGYjmau6JhzEk74d-5c9NLCbSEEy2KUxsSz4Apa7caHUUQtUayY4D_uQsAmAP9kJYhPcN8XI5waqze1GriSidw8888uFXQ6xM9Vd_Tf28M4KnId_bG3Dmgn8-yN8CyFs=w763-h441-n-k-no', 0, '2025-12-15 12:36:01'),
(12, 'Paris Getaway', 337, 'Paris, the capital of France, is one of the most romantic and culturally rich cities in the world. Known as the City of Light, Paris is famous for its elegant architecture, historic streets, and iconic landmarks that reflect centuries of art and history.\r\n\r\nThe city offers unforgettable experiences through attractions such as the Eiffel Tower, Louvre Museum, Notre-Dame Cathedral, and Champs-Élysées. With its world-class museums, fashion, cafés, and river cruises along the Seine, Paris is a perfect destination for couples, culture lovers, and international travelers.', 5, 85000, 10, 'Hotel Stay, Breakfast, Airport Transfer, City Sightseeing, Seine River Cruise\r\n', 'https://static.independent.co.uk/2025/04/25/13/42/iStock-1498516775.jpg', 1, '2025-12-15 12:36:01'),
(13, 'Dubai Luxury City Tour', 338, 'Dubai is a world-famous city in the United Arab Emirates known for its futuristic skyline, luxury lifestyle, and modern architecture. The city perfectly blends traditional Arabian culture with advanced infrastructure, offering a unique travel experience filled with elegance and innovation.\r\n\r\nDubai offers iconic attractions such as the Burj Khalifa, Palm Jumeirah, Dubai Mall, and thrilling desert safaris. Visitors can enjoy luxury shopping, adventure activities, cultural tours, and vibrant nightlife, making Dubai an ideal destination for families, couples, and international travelers.', 4, 65000, 20, 'Hotel Stay, Breakfast, Airport Transfer, City Tour, Desert Safari\r\n', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSzRb--rTYqMPxxPXg671G8EvcrF7HadT8aULnrC3IjluXMSmy8v-vzeq671EIUFha6sjjHABKpOTaXaR2TGF3eE1kKAbkDs64SxbPZo1ISSxPkvwWWCGalyxG2VeoVWiVUALLzkNg=w763-h441-n-k-no', 1, '2025-12-15 12:36:01'),
(14, 'Singapore City Explorer', 339, 'Singapore is a modern and vibrant island city known for its futuristic skyline, clean streets, and rich multicultural heritage. The city blends nature and technology beautifully, with lush gardens, iconic architecture, and world-class infrastructure that make it one of the most advanced cities in the world.\r\n\r\nSingapore offers unforgettable experiences through attractions like Marina Bay Sands, Gardens by the Bay, Sentosa Island, and Universal Studios. With its diverse food culture, safe environment, and efficient transport system, Singapore is an ideal destination for families, couples, and first-time international travelers.', 4, 70000, 18, 'Hotel Stay, Breakfast, Airport Transfer, City Tour, Sentosa Island Visit\r\n', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKGYPeIi_NYAe586B3iBSx1n0u1m5K0rtEqw&s', 0, '2025-12-15 12:36:01'),
(15, 'Bali Tropical Paradise', 340, 'Bali is a beautiful Indonesian island known for its tropical beaches, lush green rice terraces, and rich cultural heritage. The island is famous for its ancient temples, traditional dance, and peaceful atmosphere, making it a favorite destination for nature lovers and spiritual travelers.\r\n\r\nBali offers a wide range of experiences, including beach relaxation, surfing, yoga retreats, and cultural tours. Popular attractions such as Ubud, Tanah Lot Temple, and Kuta Beach make Bali an ideal destination for adventure, relaxation, and cultural exploration.', 5, 78000, 15, 'Hotel Stay, Breakfast, Airport Transfer, Temple Visit, Beach Activities\r\n', 'https://res.klook.com/image/upload/fl_lossy.progressive,q_60/Mobile/City/olvu6sgb3dcdjwlcpts3.jpg', 1, '2025-12-15 12:36:01'),
(16, 'Maldives Luxury Island Stay', 341, 'The Maldives is a tropical paradise known for its crystal-clear turquoise waters, white sandy beaches, and luxurious overwater villas. Surrounded by vibrant coral reefs and calm lagoons, it offers a peaceful and scenic environment, making it one of the most sought-after island destinations in the world.\r\n\r\nThis destination is perfect for couples, honeymooners, and travelers seeking relaxation and adventure. Activities such as snorkeling, scuba diving, island hopping, and sunset cruises allow visitors to experience the rich marine life and natural beauty, while luxury resorts provide world-class comfort and hospitality.', 5, 120000, 8, 'Resort Stay, Breakfast, Airport Transfer, Snorkeling, Island Tour\r\n', 'https://afar.brightspotcdn.com/dims4/default/ea28eda/2147483647/strip/false/crop/3000x1688+0+275/resize/1200x675!/quality/90/?url=https%3A%2F%2Fk3-prod-afar-media.s3.us-west-2.amazonaws.com%2Fbrightspot%2Fb2%2Ff4%2F9a1ebe3f427f8e5eb937f8df8998%2Ftravelguides-maldives-videomediastudioeurope-shutterstock.jpg', 1, '2025-12-15 12:36:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `package_id` (`package_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=342;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`);

--
-- Constraints for table `packages`
--
ALTER TABLE `packages`
  ADD CONSTRAINT `packages_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
