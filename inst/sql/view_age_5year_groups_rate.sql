-----------------------------------
-- 総数に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_total;
CREATE VIEW  view_age_5year_groups_rate_total AS
SELECT 
    observation_date,
    area_name,
    (0.1 * age_00_04 / age_total) as age_00_04_rate,
    (0.1 * age_05_09 / age_total) as age_05_09_rate, 
    (0.1 * age_10_14 / age_total) as age_10_14_rate,
    (0.1 * age_15_19 / age_total) as age_15_19_rate,
    (0.1 * age_20_24 / age_total) as age_20_24_rate,
    (0.1 * age_25_29 / age_total) as age_25_29_rate,
    (0.1 * age_30_34 / age_total) as age_30_34_rate,
    (0.1 * age_35_39 / age_total) as age_35_39_rate,
    (0.1 * age_40_44 / age_total) as age_40_44_rate,
    (0.1 * age_45_49 / age_total) as age_45_49_rate,
    (0.1 * age_50_54 / age_total) as age_50_54_rate,
    (0.1 * age_55_59 / age_total) as age_55_59_rate,
    (0.1 * age_60_64 / age_total) as age_60_64_rate,
    (0.1 * age_65_69 / age_total) as age_65_69_rate,
    (0.1 * age_70_74 / age_total) as age_70_74_rate,
    (0.1 * age_75_79 / age_total) as age_75_79_rate,
    (0.1 * age_80_84 / age_total) as age_80_84_rate,
    (0.1 * age_85_89 / age_total) as age_85_89_rate,
    (0.1 * age_90_94 / age_total) as age_90_94_rate,
    (0.1 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_total_v002;

-----------------------------------
-- 男性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_male;
CREATE VIEW  view_age_5year_groups_rate_male AS
SELECT 
    observation_date,
    area_name,
    (0.1 * age_00_04 / age_total) as age_00_04_rate,
    (0.1 * age_05_09 / age_total) as age_05_09_rate, 
    (0.1 * age_10_14 / age_total) as age_10_14_rate,
    (0.1 * age_15_19 / age_total) as age_15_19_rate,
    (0.1 * age_20_24 / age_total) as age_20_24_rate,
    (0.1 * age_25_29 / age_total) as age_25_29_rate,
    (0.1 * age_30_34 / age_total) as age_30_34_rate,
    (0.1 * age_35_39 / age_total) as age_35_39_rate,
    (0.1 * age_40_44 / age_total) as age_40_44_rate,
    (0.1 * age_45_49 / age_total) as age_45_49_rate,
    (0.1 * age_50_54 / age_total) as age_50_54_rate,
    (0.1 * age_55_59 / age_total) as age_55_59_rate,
    (0.1 * age_60_64 / age_total) as age_60_64_rate,
    (0.1 * age_65_69 / age_total) as age_65_69_rate,
    (0.1 * age_70_74 / age_total) as age_70_74_rate,
    (0.1 * age_75_79 / age_total) as age_75_79_rate,
    (0.1 * age_80_84 / age_total) as age_80_84_rate,
    (0.1 * age_85_89 / age_total) as age_85_89_rate,
    (0.1 * age_90_94 / age_total) as age_90_94_rate,
    (0.1 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_male_v002;

-----------------------------------
-- 女性に関するもの
-----------------------------------
DROP VIEW IF EXISTS view_age_5year_groups_rate_female;
CREATE VIEW  view_age_5year_groups_rate_female AS
SELECT 
    observation_date,
    area_name,
    (0.1 * age_00_04 / age_total) as age_00_04_rate,
    (0.1 * age_05_09 / age_total) as age_05_09_rate, 
    (0.1 * age_10_14 / age_total) as age_10_14_rate,
    (0.1 * age_15_19 / age_total) as age_15_19_rate,
    (0.1 * age_20_24 / age_total) as age_20_24_rate,
    (0.1 * age_25_29 / age_total) as age_25_29_rate,
    (0.1 * age_30_34 / age_total) as age_30_34_rate,
    (0.1 * age_35_39 / age_total) as age_35_39_rate,
    (0.1 * age_40_44 / age_total) as age_40_44_rate,
    (0.1 * age_45_49 / age_total) as age_45_49_rate,
    (0.1 * age_50_54 / age_total) as age_50_54_rate,
    (0.1 * age_55_59 / age_total) as age_55_59_rate,
    (0.1 * age_60_64 / age_total) as age_60_64_rate,
    (0.1 * age_65_69 / age_total) as age_65_69_rate,
    (0.1 * age_70_74 / age_total) as age_70_74_rate,
    (0.1 * age_75_79 / age_total) as age_75_79_rate,
    (0.1 * age_80_84 / age_total) as age_80_84_rate,
    (0.1 * age_85_89 / age_total) as age_85_89_rate,
    (0.1 * age_90_94 / age_total) as age_90_94_rate,
    (0.1 * age_95plus / age_total) as age_95plus_rate
FROM suikei_5sai_female_v002;
