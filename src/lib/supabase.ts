export interface Product {
  id: string;
  name: string;
  category: string;
  price: number;
  unit: string;
  stock: number;
  image_url: string;
  description: string;
  farmer_id: string;
  created_at: string;
  updated_at: string;
}

export interface CartItem {
  id: string;
  buyer_id: string;
  product_id: string;
  quantity: number;
  product?: Product;
}

export interface Order {
  id: string;
  buyer_id: string;
  total_amount: number;
  status: string;
  delivery_address: string;
  payment_method: string;
  created_at: string;
  updated_at: string;
}

export interface OrderItem {
  id: string;
  order_id: string;
  product_id: string;
  quantity: number;
  price_at_purchase: number;
  product?: Product;
}

export const mockProducts: Product[] = [
  {
    id: '1',
    name: 'Organic Tomatoes',
    category: 'vegetables',
    price: 2.99,
    unit: 'kg',
    stock: 50,
    image_url: 'https://images.pexels.com/photos/3608401/pexels-photo-3608401.jpeg',
    description: 'Fresh, ripe organic tomatoes sourced directly from local farmers',
    farmer_id: 'farmer1',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '2',
    name: 'Fresh Carrots',
    category: 'vegetables',
    price: 1.99,
    unit: 'kg',
    stock: 60,
    image_url: 'https://images.pexels.com/photos/2599535/pexels-photo-2599535.jpeg',
    description: 'Crispy orange carrots packed with nutrients',
    farmer_id: 'farmer2',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '3',
    name: 'Green Lettuce',
    category: 'vegetables',
    price: 2.49,
    unit: 'head',
    stock: 40,
    image_url: 'https://images.pexels.com/photos/5960606/pexels-photo-5960606.jpeg',
    description: 'Tender green lettuce perfect for salads',
    farmer_id: 'farmer1',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '4',
    name: 'Sweet Apples',
    category: 'fruits',
    price: 3.99,
    unit: 'kg',
    stock: 45,
    image_url: 'https://images.pexels.com/photos/5632533/pexels-photo-5632533.jpeg',
    description: 'Juicy and sweet apples picked fresh',
    farmer_id: 'farmer3',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '5',
    name: 'Organic Bananas',
    category: 'fruits',
    price: 1.49,
    unit: 'kg',
    stock: 70,
    image_url: 'https://images.pexels.com/photos/65174/pexels-photo-65174.jpeg',
    description: 'Golden ripe bananas full of potassium',
    farmer_id: 'farmer2',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '6',
    name: 'Strawberries',
    category: 'fruits',
    price: 4.99,
    unit: 'kg',
    stock: 35,
    image_url: 'https://images.pexels.com/photos/4551832/pexels-photo-4551832.jpeg',
    description: 'Fresh red strawberries loaded with flavor',
    farmer_id: 'farmer1',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '7',
    name: 'Bell Peppers',
    category: 'vegetables',
    price: 2.99,
    unit: 'kg',
    stock: 50,
    image_url: 'https://images.pexels.com/photos/4287967/pexels-photo-4287967.jpeg',
    description: 'Colorful bell peppers packed with vitamins',
    farmer_id: 'farmer3',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
  {
    id: '8',
    name: 'Organic Potatoes',
    category: 'vegetables',
    price: 1.49,
    unit: 'kg',
    stock: 80,
    image_url: 'https://images.pexels.com/photos/8947/pexels-photo.jpg',
    description: 'Earthy potatoes ideal for all your cooking needs',
    farmer_id: 'farmer2',
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  },
];
