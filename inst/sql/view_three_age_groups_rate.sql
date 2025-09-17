-----------------------------------
-- 総数に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_three_age_groups_rate_total;
CREATE VIEW view_three_age_groups_rate_total AS
WITH
	three_age_groups as(
    -- v002の95歳以上で区分データ
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85_89 +
         age_90_94 + age_95plus
        ) as pop_65plus
    
	FROM suikei_5sai_total_v002
	
	UNION ALL
	
    -- v001の85歳以上で区分データ
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85plus
        ) as pop_65plus
    
	FROM suikei_5sai_total_v001	
	)
SELECT
	observation_date,
    area_name,
    (1.0 * pop_0_14 / age_total) as pop_0_14_rate,
    (1.0 * pop_15_64 / age_total) as pop_15_64_rate,
    (1.0 * pop_65plus / age_total) as pop_65plus_rate
FROM three_age_groups;

-----------------------------------
-- 男性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_three_age_groups_rate_male;
CREATE VIEW view_three_age_groups_rate_male AS
WITH
	three_age_groups as(
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85_89 +
         age_90_94 + age_95plus
        ) as pop_65plus
    
	FROM suikei_5sai_male_v002
	
	UNION ALL
	
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85plus
        ) as pop_65plus
    
	FROM suikei_5sai_male_v001	
	)
SELECT
	observation_date,
    area_name,
    (1.0 * pop_0_14 / age_total) as pop_0_14_rate,
    (1.0 * pop_15_64 / age_total) as pop_15_64_rate,
    (1.0 * pop_65plus / age_total) as pop_65plus_rate
FROM three_age_groups;

-----------------------------------
-- 女性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_three_age_groups_rate_female;
CREATE VIEW view_three_age_groups_rate_female AS
WITH
	three_age_groups as(
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85_89 +
         age_90_94 + age_95plus
        ) as pop_65plus
    
	FROM suikei_5sai_female_v002
	
	UNION ALL
	
	SELECT
        observation_date,
        area_name,
    	age_total,
    
        -- 年少人口
        (age_00_04 + age_05_09 + age_10_14) as pop_0_14,
    
        -- 生産年齢人口
        (age_15_19 + age_20_24 + age_25_29 + age_30_34 + age_35_39 +
         age_40_44 + age_45_49 + age_50_54 + age_55_59 + age_60_64
        ) as pop_15_64,
    
        -- 老年人口
        (age_65_69 + age_70_74 + age_75_79 + age_80_84 + age_85plus
        ) as pop_65plus
    
	FROM suikei_5sai_female_v001	
	)
SELECT
	observation_date,
    area_name,
    (1.0 * pop_0_14 / age_total) as pop_0_14_rate,
    (1.0 * pop_15_64 / age_total) as pop_15_64_rate,
    (1.0 * pop_65plus / age_total) as pop_65plus_rate
FROM three_age_groups
