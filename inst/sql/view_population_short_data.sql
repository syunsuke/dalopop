DROP VIEW IF EXISTS view_population_data_total_short;
CREATE VIEW view_population_data_total_short AS
SELECT
    b.observation_date,
    b.area_name,
    b.total_population,
    b.male_population,
    b.female_population,
    b.total_households,
    b.total_household_size,
    mon.monthly_population_change,
    mon.monthly_natural_change,
    mon.births_monthly,
    mon.deaths_montyly,
    mon.monthly_net_migration,
    
    --5歳区分
    --総数
    CAST((b.total_population * t85.age_00_04_rate + 0.5) AS INT) AS total_age_00_04,
    CAST((b.total_population * t85.age_05_09_rate + 0.5) AS INT) AS total_age_05_09,
    CAST((b.total_population * t85.age_10_14_rate + 0.5) AS INT) AS total_age_10_14,
    CAST((b.total_population * t85.age_15_19_rate + 0.5) AS INT) AS total_age_15_19,
    CAST((b.total_population * t85.age_20_24_rate + 0.5) AS INT) AS total_age_20_24,
    CAST((b.total_population * t85.age_25_29_rate + 0.5) AS INT) AS total_age_25_29,
    CAST((b.total_population * t85.age_30_34_rate + 0.5) AS INT) AS total_age_30_34,
    CAST((b.total_population * t85.age_35_39_rate + 0.5) AS INT) AS total_age_35_39,
    CAST((b.total_population * t85.age_40_44_rate + 0.5) AS INT) AS total_age_40_44,
    CAST((b.total_population * t85.age_45_49_rate + 0.5) AS INT) AS total_age_45_49,
    CAST((b.total_population * t85.age_50_54_rate + 0.5) AS INT) AS total_age_50_54,
    CAST((b.total_population * t85.age_55_59_rate + 0.5) AS INT) AS total_age_55_59,
    CAST((b.total_population * t85.age_60_64_rate + 0.5) AS INT) AS total_age_60_64,
    CAST((b.total_population * t85.age_65_69_rate + 0.5) AS INT) AS total_age_65_69,
    CAST((b.total_population * t85.age_70_74_rate + 0.5) AS INT) AS total_age_70_74,
    CAST((b.total_population * t85.age_75_79_rate + 0.5) AS INT) AS total_age_75_79,
    CAST((b.total_population * t85.age_80_84_rate + 0.5) AS INT) AS total_age_80_84,
    CAST((b.total_population * t85.age_85plus_rate + 0.5) AS INT) AS total_age_85plus,
    
    --男性
    CAST((b.male_population * m85.age_00_04_rate + 0.5) AS INT) AS male_age_00_04,
    CAST((b.male_population * m85.age_05_09_rate + 0.5) AS INT) AS male_age_05_09,
    CAST((b.male_population * m85.age_10_14_rate + 0.5) AS INT) AS male_age_10_14,
    CAST((b.male_population * m85.age_15_19_rate + 0.5) AS INT) AS male_age_15_19,
    CAST((b.male_population * m85.age_20_24_rate + 0.5) AS INT) AS male_age_20_24,
    CAST((b.male_population * m85.age_25_29_rate + 0.5) AS INT) AS male_age_25_29,
    CAST((b.male_population * m85.age_30_34_rate + 0.5) AS INT) AS male_age_30_34,
    CAST((b.male_population * m85.age_35_39_rate + 0.5) AS INT) AS male_age_35_39,
    CAST((b.male_population * m85.age_40_44_rate + 0.5) AS INT) AS male_age_40_44,
    CAST((b.male_population * m85.age_45_49_rate + 0.5) AS INT) AS male_age_45_49,
    CAST((b.male_population * m85.age_50_54_rate + 0.5) AS INT) AS male_age_50_54,
    CAST((b.male_population * m85.age_55_59_rate + 0.5) AS INT) AS male_age_55_59,
    CAST((b.male_population * m85.age_60_64_rate + 0.5) AS INT) AS male_age_60_64,
    CAST((b.male_population * m85.age_65_69_rate + 0.5) AS INT) AS male_age_65_69,
    CAST((b.male_population * m85.age_70_74_rate + 0.5) AS INT) AS male_age_70_74,
    CAST((b.male_population * m85.age_75_79_rate + 0.5) AS INT) AS male_age_75_79,
    CAST((b.male_population * m85.age_80_84_rate + 0.5) AS INT) AS male_age_80_84,
    CAST((b.male_population * m85.age_85plus_rate + 0.5) AS INT) AS male_age_85plus,
    
    --女性
    CAST((b.female_population * f85.age_00_04_rate + 0.5) AS INT) AS female_age_00_04,
    CAST((b.female_population * f85.age_05_09_rate + 0.5) AS INT) AS female_age_05_09,
    CAST((b.female_population * f85.age_10_14_rate + 0.5) AS INT) AS female_age_10_14,
    CAST((b.female_population * f85.age_15_19_rate + 0.5) AS INT) AS female_age_15_19,
    CAST((b.female_population * f85.age_20_24_rate + 0.5) AS INT) AS female_age_20_24,
    CAST((b.female_population * f85.age_25_29_rate + 0.5) AS INT) AS female_age_25_29,
    CAST((b.female_population * f85.age_30_34_rate + 0.5) AS INT) AS female_age_30_34,
    CAST((b.female_population * f85.age_35_39_rate + 0.5) AS INT) AS female_age_35_39,
    CAST((b.female_population * f85.age_40_44_rate + 0.5) AS INT) AS female_age_40_44,
    CAST((b.female_population * f85.age_45_49_rate + 0.5) AS INT) AS female_age_45_49,
    CAST((b.female_population * f85.age_50_54_rate + 0.5) AS INT) AS female_age_50_54,
    CAST((b.female_population * f85.age_55_59_rate + 0.5) AS INT) AS female_age_55_59,
    CAST((b.female_population * f85.age_60_64_rate + 0.5) AS INT) AS female_age_60_64,
    CAST((b.female_population * f85.age_65_69_rate + 0.5) AS INT) AS female_age_65_69,
    CAST((b.female_population * f85.age_70_74_rate + 0.5) AS INT) AS female_age_70_74,
    CAST((b.female_population * f85.age_75_79_rate + 0.5) AS INT) AS female_age_75_79,
    CAST((b.female_population * f85.age_80_84_rate + 0.5) AS INT) AS female_age_80_84,
    CAST((b.female_population * f85.age_85plus_rate + 0.5) AS INT) AS female_age_85plus,
    
    --3区分
    --総数
    CAST((b.total_population * t3.pop_0_14_rate + 0.5) AS INT) AS total_pop_0_14,
    CAST((b.total_population * t3.pop_15_64_rate + 0.5) AS INT) AS total_pop_15_64,
    CAST((b.total_population * t3.pop_65plus_rate + 0.5) AS INT) AS total_pop_65plus,
    
    --男性
    CAST((b.male_population * m3.pop_0_14_rate + 0.5) AS INT) AS male_pop_0_14,
    CAST((b.male_population * m3.pop_15_64_rate + 0.5) AS INT) AS male_pop_15_64,
    CAST((b.male_population * m3.pop_65plus_rate + 0.5) AS INT) AS male_pop_65plus,
    
    --女性
    CAST((b.female_population * f3.pop_0_14_rate + 0.5) AS INT) AS female_pop_0_14,
    CAST((b.female_population * f3.pop_15_64_rate + 0.5) AS INT) AS female_pop_15_64,
    CAST((b.female_population * f3.pop_65plus_rate + 0.5) AS INT) AS female_pop_65plus

-- BASE
FROM view_base_data b

-- 月移動
LEFT JOIN view_monthly_chage_data mon
ON b.observation_date = mon.observation_date
AND b.area_name = mon.area_name

-- 85歳以上区分 total
LEFT JOIN view_age_5year_short_groups_rate_total t85
ON b.observation_date = t85.observation_date
AND b.area_name = t85.area_name

-- 85歳以上区分 male 
LEFT JOIN view_age_5year_short_groups_rate_male m85
ON b.observation_date = m85.observation_date
AND b.area_name = m85.area_name

-- 85歳以上区分 female 
LEFT JOIN view_age_5year_short_groups_rate_male f85
ON b.observation_date = f85.observation_date
AND b.area_name = f85.area_name

-- 3区分 total
LEFT JOIN view_three_age_groups_rate_total t3
ON b.observation_date = t3.observation_date
AND b.area_name = t3.area_name

-- 3区分 male
LEFT JOIN view_three_age_groups_rate_total m3
ON b.observation_date = m3.observation_date
AND b.area_name = m3.area_name

-- 3区分 female
LEFT JOIN view_three_age_groups_rate_total f3
ON b.observation_date = f3.observation_date
AND b.area_name = f3.area_name
