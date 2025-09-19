-----------------------------------
-- 総数に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_total;
CREATE VIEW  view_age_5year_groups_rate_total AS
SELECT 
    observation_date,
    area_name,
    (1.0 * age_00_04 / age_total) as age_00_04_rate,
    (1.0 * age_05_09 / age_total) as age_05_09_rate, 
    (1.0 * age_10_14 / age_total) as age_10_14_rate,
    (1.0 * age_15_19 / age_total) as age_15_19_rate,
    (1.0 * age_20_24 / age_total) as age_20_24_rate,
    (1.0 * age_25_29 / age_total) as age_25_29_rate,
    (1.0 * age_30_34 / age_total) as age_30_34_rate,
    (1.0 * age_35_39 / age_total) as age_35_39_rate,
    (1.0 * age_40_44 / age_total) as age_40_44_rate,
    (1.0 * age_45_49 / age_total) as age_45_49_rate,
    (1.0 * age_50_54 / age_total) as age_50_54_rate,
    (1.0 * age_55_59 / age_total) as age_55_59_rate,
    (1.0 * age_60_64 / age_total) as age_60_64_rate,
    (1.0 * age_65_69 / age_total) as age_65_69_rate,
    (1.0 * age_70_74 / age_total) as age_70_74_rate,
    (1.0 * age_75_79 / age_total) as age_75_79_rate,
    (1.0 * age_80_84 / age_total) as age_80_84_rate,
    (1.0 * age_85_89 / age_total) as age_85_89_rate,
    (1.0 * age_90_94 / age_total) as age_90_94_rate,
    (1.0 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_total_v002;

-----------------------------------
-- 男性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_male;
CREATE VIEW  view_age_5year_groups_rate_male AS
SELECT 
    observation_date,
    area_name,
    (1.0 * age_00_04 / age_total) as age_00_04_rate,
    (1.0 * age_05_09 / age_total) as age_05_09_rate, 
    (1.0 * age_10_14 / age_total) as age_10_14_rate,
    (1.0 * age_15_19 / age_total) as age_15_19_rate,
    (1.0 * age_20_24 / age_total) as age_20_24_rate,
    (1.0 * age_25_29 / age_total) as age_25_29_rate,
    (1.0 * age_30_34 / age_total) as age_30_34_rate,
    (1.0 * age_35_39 / age_total) as age_35_39_rate,
    (1.0 * age_40_44 / age_total) as age_40_44_rate,
    (1.0 * age_45_49 / age_total) as age_45_49_rate,
    (1.0 * age_50_54 / age_total) as age_50_54_rate,
    (1.0 * age_55_59 / age_total) as age_55_59_rate,
    (1.0 * age_60_64 / age_total) as age_60_64_rate,
    (1.0 * age_65_69 / age_total) as age_65_69_rate,
    (1.0 * age_70_74 / age_total) as age_70_74_rate,
    (1.0 * age_75_79 / age_total) as age_75_79_rate,
    (1.0 * age_80_84 / age_total) as age_80_84_rate,
    (1.0 * age_85_89 / age_total) as age_85_89_rate,
    (1.0 * age_90_94 / age_total) as age_90_94_rate,
    (1.0 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_male_v002;

-----------------------------------
-- 女性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_female;
CREATE VIEW  view_age_5year_groups_rate_female AS
SELECT 
    observation_date,
    area_name,
    (1.0 * age_00_04 / age_total) as age_00_04_rate,
    (1.0 * age_05_09 / age_total) as age_05_09_rate, 
    (1.0 * age_10_14 / age_total) as age_10_14_rate,
    (1.0 * age_15_19 / age_total) as age_15_19_rate,
    (1.0 * age_20_24 / age_total) as age_20_24_rate,
    (1.0 * age_25_29 / age_total) as age_25_29_rate,
    (1.0 * age_30_34 / age_total) as age_30_34_rate,
    (1.0 * age_35_39 / age_total) as age_35_39_rate,
    (1.0 * age_40_44 / age_total) as age_40_44_rate,
    (1.0 * age_45_49 / age_total) as age_45_49_rate,
    (1.0 * age_50_54 / age_total) as age_50_54_rate,
    (1.0 * age_55_59 / age_total) as age_55_59_rate,
    (1.0 * age_60_64 / age_total) as age_60_64_rate,
    (1.0 * age_65_69 / age_total) as age_65_69_rate,
    (1.0 * age_70_74 / age_total) as age_70_74_rate,
    (1.0 * age_75_79 / age_total) as age_75_79_rate,
    (1.0 * age_80_84 / age_total) as age_80_84_rate,
    (1.0 * age_85_89 / age_total) as age_85_89_rate,
    (1.0 * age_90_94 / age_total) as age_90_94_rate,
    (1.0 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_female_v002;
