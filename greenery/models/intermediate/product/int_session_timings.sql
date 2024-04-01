select
        session_id,
        min(created_at) as session_started_at,
        max(created_at) as session_ended_at
    from dev_db.dbt_adebayoadeniyi650gmailcom.stg_postgres__events
    group by 1