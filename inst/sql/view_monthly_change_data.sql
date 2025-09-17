DROP VIEW IF EXISTS view_monthly_chage_data;
CREATE VIEW view_monthly_chage_data AS
SELECT
    observation_date,
    area_name,
    -- 月毎変動
    monthly_population_change,
    monthly_natural_change,
    births_monthly,
    deaths_montyly,
    monthly_net_migration
FROM suikei

