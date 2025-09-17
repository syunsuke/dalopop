DROP VIEW IF EXISTS view_base_data;
CREATE VIEW view_base_data AS

WITH 
    unified AS (
    -- 修正データ（優先度１）
    SELECT
        observation_date,
        area_name,
        total_population,
        male_population,
        female_population,
        total_households,
        1 AS pref
    FROM syusei
    
    UNION ALL
    
    -- 推計データ（優先度2）
    SELECT
        observation_date,
        area_name,
        total_population,
        male_population,
        female_population,
        total_households,
        2 AS pref
    FROM suikei		
    ),
    
    ----------------------------------------
    -- 修正と推計の選択
    ----------------------------------------
    ranked as (
    SELECT 
        u.*,
        ROW_NUMBER() OVER(
            PARTITION by observation_date, area_name
            ORDER by pref ASC
        ) AS rn
    FROM unified u
    ),
    
    unified_result AS(
    SELECT
        observation_date,
        area_name,
        total_population,
        male_population,
        female_population,
        total_households,
        (1.0 * total_population / total_households) as total_household_size
    from ranked
    where rn = 1
    ),

    ------------------------------------------
    -- 修正、推計での振り分け後 国調データと結合 
    ------------------------------------------
    result AS (
    SELECT
        observation_date,
        area_name,
        total_population,
        male_population,
        female_population,
        total_households,
        (1.0 * total_population / total_households) as total_household_size
    FROM census
    
    UNION ALL
    
    SELECT * FROM unified_result
    )
-- WITHの最終結果
SELECT * FROM result;

