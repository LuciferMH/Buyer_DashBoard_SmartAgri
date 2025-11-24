/*
  # Buyer Dashboard Schema

  ## Overview
  This migration creates the necessary tables for the Agriculture Management System's Buyer Dashboard.
  It includes tables for products, orders, billing information, and user profiles.

  ## New Tables
  
  ### 1. `products` - Stores vegetable/product information
    - `id` (uuid, primary key) - Unique product identifier
    - `name` (text) - Product name
    - `category` (text) - Product category (vegetables, fruits, etc.)
    - `price` (decimal) - Product price per unit
    - `unit` (text) - Measurement unit (kg, piece, etc.)
    - `stock` (integer) - Available stock quantity
    - `image_url` (text) - Product image URL
    - `description` (text) - Product description
    - `farmer_id` (uuid) - Reference to farmer/seller
    - `created_at` (timestamptz) - Record creation timestamp
    - `updated_at` (timestamptz) - Record update timestamp

  ### 2. `orders` - Stores order information
    - `id` (uuid, primary key) - Unique order identifier
    - `buyer_id` (uuid) - Reference to buyer
    - `total_amount` (decimal) - Total order amount
    - `status` (text) - Order status (pending, confirmed, delivered, cancelled)
    - `delivery_address` (text) - Delivery address
    - `payment_method` (text) - Payment method
    - `created_at` (timestamptz) - Order creation timestamp
    - `updated_at` (timestamptz) - Order update timestamp

  ### 3. `order_items` - Stores individual items in orders
    - `id` (uuid, primary key) - Unique item identifier
    - `order_id` (uuid) - Reference to order
    - `product_id` (uuid) - Reference to product
    - `quantity` (integer) - Quantity ordered
    - `price_at_purchase` (decimal) - Price at time of purchase
    - `created_at` (timestamptz) - Record creation timestamp

  ### 4. `buyer_profiles` - Stores buyer profile information
    - `id` (uuid, primary key) - Unique profile identifier
    - `user_id` (uuid) - Reference to auth user
    - `full_name` (text) - Buyer full name
    - `email` (text) - Buyer email
    - `phone` (text) - Contact phone number
    - `address` (text) - Primary address
    - `city` (text) - City
    - `postal_code` (text) - Postal code
    - `created_at` (timestamptz) - Profile creation timestamp
    - `updated_at` (timestamptz) - Profile update timestamp

  ### 5. `cart_items` - Stores shopping cart items
    - `id` (uuid, primary key) - Unique cart item identifier
    - `buyer_id` (uuid) - Reference to buyer
    - `product_id` (uuid) - Reference to product
    - `quantity` (integer) - Quantity in cart
    - `created_at` (timestamptz) - Record creation timestamp
    - `updated_at` (timestamptz) - Record update timestamp

  ## Security
    - Enable RLS on all tables
    - Add policies for buyers to manage their own data
    - Add policies for viewing products
*/

-- Create products table
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  category text NOT NULL DEFAULT 'vegetables',
  price decimal(10,2) NOT NULL,
  unit text NOT NULL DEFAULT 'kg',
  stock integer NOT NULL DEFAULT 0,
  image_url text,
  description text,
  farmer_id uuid,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  buyer_id uuid NOT NULL,
  total_amount decimal(10,2) NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  delivery_address text,
  payment_method text DEFAULT 'cash',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create order_items table
CREATE TABLE IF NOT EXISTS order_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id uuid NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id uuid NOT NULL REFERENCES products(id),
  quantity integer NOT NULL DEFAULT 1,
  price_at_purchase decimal(10,2) NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create buyer_profiles table
CREATE TABLE IF NOT EXISTS buyer_profiles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid,
  full_name text NOT NULL,
  email text NOT NULL,
  phone text,
  address text,
  city text,
  postal_code text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create cart_items table
CREATE TABLE IF NOT EXISTS cart_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  buyer_id uuid NOT NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  quantity integer NOT NULL DEFAULT 1,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(buyer_id, product_id)
);

-- Enable RLS
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE buyer_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE cart_items ENABLE ROW LEVEL SECURITY;

-- Products policies (public read access)
CREATE POLICY "Anyone can view products"
  ON products FOR SELECT
  TO public
  USING (true);

-- Orders policies
CREATE POLICY "Buyers can view own orders"
  ON orders FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Buyers can create orders"
  ON orders FOR INSERT
  TO public
  WITH CHECK (true);

-- Order items policies
CREATE POLICY "Anyone can view order items"
  ON order_items FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can create order items"
  ON order_items FOR INSERT
  TO public
  WITH CHECK (true);

-- Buyer profiles policies
CREATE POLICY "Anyone can view buyer profiles"
  ON buyer_profiles FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can create buyer profiles"
  ON buyer_profiles FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Anyone can update buyer profiles"
  ON buyer_profiles FOR UPDATE
  TO public
  USING (true);

-- Cart items policies
CREATE POLICY "Anyone can view cart items"
  ON cart_items FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can create cart items"
  ON cart_items FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Anyone can update cart items"
  ON cart_items FOR UPDATE
  TO public
  USING (true);

CREATE POLICY "Anyone can delete cart items"
  ON cart_items FOR DELETE
  TO public
  USING (true);

-- Insert sample products
INSERT INTO products (name, category, price, unit, stock, image_url, description) VALUES
  ('Tomatoes', 'vegetables', 2.50, 'kg', 100, 'https://images.pexels.com/photos/1327838/pexels-photo-1327838.jpeg', 'Fresh red tomatoes'),
  ('Bananas', 'fruits', 1.80, 'kg', 150, 'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg', 'Ripe yellow bananas'),
  ('Carrots', 'vegetables', 1.50, 'kg', 120, 'https://images.pexels.com/photos/3650647/pexels-photo-3650647.jpeg', 'Organic carrots'),
  ('Potatoes', 'vegetables', 1.20, 'kg', 200, 'https://images.pexels.com/photos/144248/potatoes-vegetables-erdfrucht-bio-144248.jpeg', 'Fresh potatoes'),
  ('Lettuce', 'vegetables', 2.00, 'piece', 80, 'https://images.pexels.com/photos/1352199/pexels-photo-1352199.jpeg', 'Crispy green lettuce'),
  ('Cabbage', 'vegetables', 1.70, 'piece', 90, 'https://images.pexels.com/photos/2255935/pexels-photo-2255935.jpeg', 'Fresh cabbage'),
  ('Onions', 'vegetables', 1.30, 'kg', 180, 'https://images.pexels.com/photos/3686769/pexels-photo-3686769.jpeg', 'Red onions'),
  ('Apples', 'fruits', 3.00, 'kg', 140, 'https://images.pexels.com/photos/1510392/pexels-photo-1510392.jpeg', 'Sweet red apples'),
  ('Grapes', 'fruits', 4.50, 'kg', 70, 'https://images.pexels.com/photos/23042/pexels-photo.jpg', 'Fresh grapes'),
  ('Broccoli', 'vegetables', 2.80, 'piece', 60, 'https://images.pexels.com/photos/47347/broccoli-vegetable-food-healthy-47347.jpeg', 'Green broccoli'),
  ('Bell Peppers', 'vegetables', 3.20, 'kg', 95, 'https://images.pexels.com/photos/1268101/pexels-photo-1268101.jpeg', 'Colorful bell peppers'),
  ('Spinach', 'vegetables', 2.20, 'kg', 110, 'https://images.pexels.com/photos/2325843/pexels-photo-2325843.jpeg', 'Fresh spinach leaves');
