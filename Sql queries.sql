# Year wise sales report:
SELECT year(od.orderDate) years,
SUM(odl.quantityOrdered) total_orders,
SUM(odl.priceEach * odl.quantityOrdered) total_sales
FROM orders od
inner join orderdetails odl
on od.ordernumber = odl.ordernumber
group by years;


# This is to understand why customers are canceling the orders.
select comments from orders where status = 'Cancelled';


# The top customers with the highest payment:
select c.customerName, concat(c.contactFirstName,' ',c.contactLastName) as Purchaser,
 sum(p.amount) as total_payment from payments p 
inner join customers c on p.customerNumber = c.customerNumber
group by p.customerNumber order by total_payment desc limit 15;


# The largest suppleyer of products
select productvendor, count(productname) as total_products, sum(quantityInStock) as total_quantity_in_stock 
from products group by productVendor order by total_quantity_in_stock desc;


# Offices in diffeerent cities with the highest contribution to sales
select o.officeCode, o.city as office_city, count( e.employeeNumber) as total_no_of_employees,
 sum(odd.quantityOrdered) as total_orders_sold, 
 sum(odd.priceEach * odd.quantityOrdered) as total_sales from offices o 
inner join employees e on e.officeCode = o.officeCode
inner join customers c on c.salesRepEmployeeNumber = e.employeeNumber
inner join orders od on od.customerNumber = c.customerNumber
inner join orderdetails odd on odd.orderNumber = od.orderNumber
group by o.officeCode order by total_sales desc;


# Largest customers who traded with more than twice the amount of average customers
select c.customerName, p.amount from payments p 
inner join customers c on c.customerNumber = p.customerNumber
where amount > (select avg(amount)*2 from payments);


# Comparison of buy price vs msrp vs average sold price
select p.productname, round(avg(p.buyPrice),1) as baught_price,
 round(avg(p.MSRP),1) as msrp,
 round(avg(o.priceeach),1) as average_sold_price from products p
inner join orderdetails o on o.productCode = p.productCode
group by p.productName;


# City wise sales report, cities with the highest sales
select c.city, sum(od.quantityOrdered) as total_orders_sold, 
 sum(od.priceEach * od.quantityOrdered) as total_sales from customers c 
inner join orders o on o.customerNumber = c.customerNumber
inner join orderdetails od on od.orderNumber
group by c.city order by total_sales desc;


# State wise sales report, states with the highest sales
select c.state, sum(od.quantityOrdered) as total_orders_sold, 
 sum(od.priceEach * od.quantityOrdered) as total_sales from customers c 
inner join orders o on o.customerNumber = c.customerNumber
inner join orderdetails od on od.orderNumber
group by c.state order by total_sales desc;


# Country wise sales report, country with the highest sales
select c.country, sum(od.quantityOrdered) as total_orders_sold, 
 sum(od.priceEach * od.quantityOrdered) as total_sales from customers c 
inner join orders o on o.customerNumber = c.customerNumber
inner join orderdetails od on od.orderNumber
group by c.country order by total_sales desc;