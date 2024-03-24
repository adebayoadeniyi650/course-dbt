select
    EVENT_ID,
	SESSION_ID,
	USER_ID,
	PAGE_URL,
	CREATED_AT,
	EVENT_TYPE,
	PRODUCT_ID
from {{source ('postgres','Events')}}