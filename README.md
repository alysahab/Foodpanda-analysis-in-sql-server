# Online Food Delivery Case Study

This repository contains a case study on online food delivery implemented in `SQL server`. The study explores various aspects of the online food delivery domain using a relational database model. Below is an overview of the data tables and the scope of analysis covered.

### Data Tables

1. **users**: Contains information about users registered on the platform.
   - Columns: user_id, name, email, password

2. **restaurants**: Stores details about restaurants available on the platform.
   - Columns: r_id, r_name, cuisine

3. **food**: Includes information about different food items offered by restaurants.
   - Columns: f_id, f_name, type

4. **menu**: Describes the menu items available at each restaurant along with their prices.
   - Columns: menu_id, r_id, f_id, price

5. **orders**: Captures details of orders placed by users.
   - Columns: order_id, user_id, r_id, amount, date, partner_id, delivery_time, delivery_rating, restaurant_rating

### Scope of Analysis

The case study covers various analytical questions related to the online food delivery system. These questions aim to provide insights into customer behavior, restaurant performance, revenue trends, and product associations. The queries developed for analysis are as follows:

1. Find customers who have never ordered
2. Average Price/dish
3. Find the top restaurant in terms of the number of orders for a given month
4. Restaurants with monthly sales greater than x
5. Show all orders with order details for a particular customer in a particular date range
6. Find restaurants with max repeated customers
7. Month over month revenue growth of Swiggy
8. Customer - favorite food
9. Find the most loyal customers for all restaurants
10. Month over month revenue growth of a restaurant
11. Most Paired Products

### File Structure

- **Scripts**: Contains SQL scripts for each of the analytical questions.
- **Datasets**: Includes the datasets used for the case study.

Feel free to explore the repository to gain insights into the online food delivery system analyzed in this case study. If you have any questions or suggestions, please don't hesitate to reach out. Happy analyzing!
