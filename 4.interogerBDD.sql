/*exo1*/

select concat(emp_lastname,' ', emp_firstname), emp_children from employees
where emp_children>0
ORDER BY emp_children DESC

/*exo2*/

select cus_lastname, cus_firstname, cus_countries_id from customers
where cus_countries_id not like 'FR'
order by cus_countries_id ASC

/*exo3*/

select cus_city, cus_countries_id, cou_name from customers
join countries on cus_countries_id=cou_id
order by cus_city ASC

/*exo4*/

select cus_lastname, cus_update_date from customers
where cus_update_date is not null

/*exo5*/

select cus_id, cus_lastname, cus_firstname, cus_city from customers
where cus_city like '%divos%'

/*exo6*/

select pro_id, pro_name, MIN(pro_price)
from products
group by pro_price
limit 1 

/*exo7*/

select pro_id, pro_ref, pro_name from products
where pro_id NOT IN (select pro_id from products
join orders_details on ode_pro_id=pro_id where ode_quantity>0)
group by pro_id

/*exo8*/

select pro_id, pro_ref, pro_name, cus_id, ord_id, ode_id
from customers
join orders on ord_cus_id=cus_id
join orders_details on ord_id=ode_ord_id
join products on ode_pro_id=pro_id
where cus_lastname='Pikatchien'


/*exo9*/

SELECT `cat_id`, `cat_name`, pro_name
from categories
join products on pro_cat_id=cat_id
group by pro_name ASC

/*exo10 ?????? pas reussi copletement, affiche que Employe et son post*/

SELECT concat(emp_lastname, ' ', emp_firstname) as 'Employé', pos_libelle, 
(select concat(emp_lastname, ' ', emp_firstname)
from employees
where `emp_superior_id`=`emp_id`) as 'Supérieur'
from employees
JOIN shops on `emp_sho_id`=sho_id
join posts on `emp_pos_id`=pos_id
where emp_superior_id is not null AND
sho_city='Compiègne'
group by concat(emp_lastname, ' ', emp_firstname) ASC

/*exo11*/

SELECT MAX(ode_discount), ode_id, ord_id, pro_id, pro_name
from products
join orders_details on ode_pro_id=pro_id
join orders on ode_ord_id=ord_id
group by ode_discount DESC
limit 1

/*exo13*/


select COUNT(cus_countries_id) as 'Nb clients Canada'
from customers
join countries
on cus_countries_id=cou_id
where cou_name='Canada'

/*exo16*/


SELECT `ode_id`, `ode_unit_price`, `ode_discount`, `ode_quantity`, `ode_ord_id`, `ode_pro_id`, ord_order_date 
FROM `orders_details` 
join orders 
on ord_id=`ode_ord_id` 
where SUBSTRING(ord_order_date, 1, 4)='2020'

/*exo17*/


select sup_id, sup_name, sup_city, sup_countries_id, sup_address, sup_contact, sup_phone, sup_mail
from suppliers
where sup_id NOT IN (select sup_id from suppliers
join products
on pro_sup_id=sup_id
join orders_details
on ode_pro_id=pro_id
where ode_quantity>0)


/*exo18*/


select SUM(`ode_unit_price`*`ode_quantity`-`ode_discount`) as 'chiffre 2020'
from orders_details
join orders
on `ode_ord_id`=ord_id
where SUBSTRING(ord_order_date, 1, 4)='2020'


/*exo19*/


SELECT AVG(`ode_unit_price`*`ode_quantity`-`ode_discount`) as 'panier moyen'
FROM orders_details


/*exo20*/


select `ode_ord_id`as 'numéro de commande', ord_order_date as 'date de commande', (`ode_unit_price`*`ode_quantity`-`ode_discount`) as 'total', concat(cus_lastname, ' ', cus_firstname) as 'nom client'
from orders_details
join orders on `ode_ord_id`=ord_id
join customers on ord_cus_id=cus_id
order by (`ode_unit_price`*`ode_quantity`-`ode_discount`) DESC


/*22*/


update products
set pro_price=pro_price-0.9,
pro_name='Camper'
where pro_id='12'


/*23*/


UPDATE `products`
SET `pro_price`=`pro_price`*1.011
where pro_id BETWEEN 25 and 27


/*24 pas reussi, dessous il y a mes 3 variantes*/


delete from products
where `pro_id` not in (select `pro_id`
              from products
              join orders_details on ode_pro_id=pro_id
              where ode_quantity>0)
              and `pro_cat_id` in (select `pro_cat_id`
                                   from products
                                   join categories
                                   on `pro_cat_id`=cat_id
                                   where cat_id='Tondeuses électriques')


delete from products
where `pro_id` not in (select `ode_quantity`
              from orders_details
              where ode_quantity>0)
              and `pro_cat_id` in (select `cat_id`
                                   from categories
                                   where cat_id='Tondeuses électriques')


delete from products
join orders_details on ode_pro_id=pro_id
join categories on `pro_cat_id`=cat_id
where `ode_quantity` not in (select `ode_quantity`
              from orders_details
              where ode_quantity>0)
              and `pro_cat_id` in (select `cat_id`
                                   from categories
                                   where cat_id='Tondeuses électriques')