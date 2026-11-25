# Cloud E-commerce Database (PostgreSQL)

PostgreSQL database schema for a cloud-based e-commerce application hosted on AWS RDS.

## Database Details
- **Database:** `cloud`
- **Engine:** PostgreSQL
- **Host:** AWS RDS
- **Port:** `5432`
- **Client:** `psql`

## Tables
- `users`
- `pending_signups`
- `cart_items`
- `orders`
- `order_items`
- `payments`
- `recharges`
- `service_activity`

## Setup and Deployment

### 1. Install PostgreSQL Client on Ubuntu

```bash
sudo apt update
sudo apt install postgresql-client -y
```

Verify installation:

```bash
psql --version
```

### 2. Create the Database

```bash
psql -h database-1.cwbe2qaeun8l.us-east-1.rds.amazonaws.com -U postgres -d postgres -c "CREATE DATABASE cloud;"
```

### 3. Execute the SQL File

```bash
psql -h database-1.cwbe2qaeun8l.us-east-1.rds.amazonaws.com -U postgres -d cloud -f cloud.sql
```

Enter your RDS password when prompted.

### 4. Verify Tables

Connect to the database:

```bash
psql -h database-1.cwbe2qaeun8l.us-east-1.rds.amazonaws.com -U postgres -d cloud
```

List tables:

```sql
\dt
```

## Features
- Primary and foreign keys
- Unique constraints
- Automatic ID generation
- Timestamp tracking
- Cascading delete relationships

## Technologies
- PostgreSQL
- AWS RDS
- Ubuntu
- PostgreSQL Client (`psql`)
