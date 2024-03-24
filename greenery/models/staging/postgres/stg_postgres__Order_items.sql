select
    ORDER_ID,
	PRODUCT_ID,
	QUANTITY NUMBER
from {{source ('postgres','Order_items')}}