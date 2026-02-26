# Hive Telecom Data Optimization Project

## Overview

This project demonstrates how Hive partitioning and bucketing can be used to optimize telecom analytics workloads involving call records, data usage, and SMS activity.

The goal was to improve query performance for:
- Date-based filtering
- Region-based reporting
- Customer-level analytics
- Heavy user identification

---

## Architecture

Raw CSV Data (HDFS)
        ↓
External Hive Tables (TEXTFILE)
        ↓
Managed Hive Tables (ORC Format)
        ↓
Partitioning (call_date, region)
        ↓
Bucketing (customer_id)
        ↓
Optimized Analytical Queries

---

## Optimization Techniques Used

### 1. Partitioning
- Partitioned by date and region
- Enables partition pruning
- Reduces full-table scans

### 2. Bucketing
- Bucketed by customer_id
- Enables efficient joins
- Improves GROUP BY performance

### 3. ORC Storage Format
- Columnar storage
- Compression enabled
- Built-in indexing
- Faster analytical queries

---

## Key Queries

- Total call duration by date and region
- Top data users by region
- SMS usage trends

---

## Technologies Used

- Hadoop (HDFS)
- Hive
- ORC File Format
- Docker
- Git & GitHub

---

## Author

Reju Karkee# Hive Telecom Case Study (Partitioning & Bucketing)

This project contains sample telecom datasets used to practice Hive optimization concepts:
- Partitioning by date and region
- Bucketing by customer_id
- External table (raw) → Managed ORC table (optimized) using INSERT OVERWRITE

## Files
- calldata: call usage sample data (CSV)
- datausage: data usage sample data (CSV)
- smsdata: SMS usage sample data (CSV)
