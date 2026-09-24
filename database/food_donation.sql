CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('restaurant','ngo','volunteer','admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_name VARCHAR(150) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE ngos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ngo_name VARCHAR(150) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE volunteers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_type VARCHAR(50),
    status VARCHAR(30) DEFAULT 'Available',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE donations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    food_name VARCHAR(150) NOT NULL,
    food_type VARCHAR(100),
    quantity INT NOT NULL,
    unit VARCHAR(50),
    preparation_time DATETIME,
    expiry_time DATETIME,
    pickup_address TEXT,
    status VARCHAR(50) DEFAULT 'Available',
    ngo_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

CREATE TABLE pickup_schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donation_id INT NOT NULL,
    volunteer_id INT NOT NULL,
    pickup_date DATE,
    pickup_time TIME,
    pickup_status VARCHAR(50) DEFAULT 'Scheduled',
    delivery_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (donation_id) REFERENCES donations(id),
    FOREIGN KEY (volunteer_id) REFERENCES volunteers(id)
);

CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    donation_id INT,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE donation_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donation_id INT NOT NULL,
    status VARCHAR(50),
    remarks TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
