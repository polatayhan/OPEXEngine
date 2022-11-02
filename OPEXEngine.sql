-- Host: 127.0.0.1 Database: MySweetSaas

CREATE DATABASE IF NOT EXISTS MySweetSaas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ------------------------------------------------------
-- Server version 8.0.31

USE MySweetSaas;

-- Create table: `companies`

CREATE TABLE `companies` (
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'Company unique id',
    `title` varchar(255) NOT NULL COMMENT 'Company''s title. This is not unique because same name companies possible',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Company''s created date time',
    `is_activated` boolean NOT NULL DEFAULT '0' COMMENT 'Company''s activation status (1: Activated, 0: Not Activated)',
    `activated_at` datetime DEFAULT NULL COMMENT 'Company''s activation date time',
    `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Company''s deletion status (soft-delete. 1: Deleted, 0: Not Deleted)',
    `deleted_at` datetime DEFAULT NULL COMMENT 'Company''s deletion date time',
    PRIMARY KEY (`id`),
    UNIQUE KEY `id` (`id`)
) COMMENT='Companies table';

-- Insert data to: `companies`

INSERT INTO `companies` (`id`, `title`, `created_at`, `is_activated`, `activated_at`, `is_deleted`, `deleted_at`) VALUES (1,'OPEXEngine','2022-11-01 22:01:13',1,'2022-11-01 17:01:40',0,NULL);
INSERT INTO `companies` (`id`, `title`, `created_at`, `is_activated`, `activated_at`, `is_deleted`, `deleted_at`) VALUES (2,'Sweet Ice Cream Truck','2022-11-01 19:18:49',0,'2022-11-01 19:18:57',1,'2022-11-01 20:19:05');

-- Create table: `company_addresses`

CREATE TABLE `company_addresses` (
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'Company address''s unique id',
    `company_id` int NOT NULL COMMENT 'Company address''s owner company id. This is not unique. A company can have multiple addresses of the same type.',
    `address_type` enum('Office','Warehouse','Branch') NOT NULL DEFAULT 'Office' COMMENT 'Company address''s address type (We can use table for address types). This is not unique. A company can have multiple addresses of the same type.',
    `address` varchar(100) NOT NULL COMMENT 'Company address',
    `address2` varchar(100) DEFAULT NULL COMMENT 'Company address2',
    `district` varchar(50) NOT NULL COMMENT 'Company address''s district',
    `city` varchar(50) NOT NULL COMMENT 'Company address''s city (We can use city table and foreign to this column)',
    `state` varchar(50) NOT NULL COMMENT 'Company address''s state',
    `zip_code` varchar(10) DEFAULT NULL COMMENT 'Company address''s zip code',
    `phone_number` varchar(20) DEFAULT NULL COMMENT 'Company address''s phone number',
    PRIMARY KEY (`id`),
    UNIQUE KEY `id` (`id`),
    KEY `company_addresses_companies_id_fk` (`company_id`),
    CONSTRAINT `company_addresses_companies_id_fk` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='Company addresses table';

-- Insert data to: `company_addresses`

INSERT INTO `company_addresses` (`id`, `company_id`, `address_type`, `address`, `address2`, `district`, `city`, `state`, `zip_code`, `phone_number`) VALUES (1,1,'Office','738 Main Street',NULL,' #207','Waltham','MA','02451','202-456-1111');
INSERT INTO `company_addresses` (`id`, `company_id`, `address_type`, `address`, `address2`, `district`, `city`, `state`, `zip_code`, `phone_number`) VALUES (2,1,'Warehouse','Nasa Area',NULL,'Rocket','Houston','TX','12345','123-456-7890');
INSERT INTO `company_addresses` (`id`, `company_id`, `address_type`, `address`, `address2`, `district`, `city`, `state`, `zip_code`, `phone_number`) VALUES (3,2,'Office','Riverside',NULL,'Greenville','Moon','SPC','54321','098-765-4321');

-- Create table: `users`

CREATE TABLE `users` (
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'User data''s unique id',
    `email` varchar(50) NOT NULL COMMENT 'User''s email address',
    `password` varchar(250) NOT NULL COMMENT 'User''s hashed password',
    `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'User''s created date time',
    `is_activated` tinyint(1) DEFAULT '0' COMMENT 'User''s system level status (1: Activated, 0: Not Activated)',
    `activated_at` datetime DEFAULT NULL COMMENT 'User''s activated date time',
    `is_deleted` tinyint(1) DEFAULT '0' COMMENT 'User''s deletion status (soft-delete. 1: Deleted, 0: Not Deleted)',
    `deleted_at` datetime DEFAULT NULL COMMENT 'User''s deletion date time',
    PRIMARY KEY (`id`),
    UNIQUE KEY `id` (`id`),
    UNIQUE KEY `email` (`email`)
) COMMENT='Users table';

-- Insert data to: `users`

INSERT INTO `users` (`id`, `email`, `password`, `created_at`, `is_activated`, `activated_at`, `is_deleted`, `deleted_at`) VALUES (1,'hello@ayhanpolat.com.tr','myHashedPassword','2022-11-01 13:53:26',1,'2022-11-01 13:53:32',0,NULL);
INSERT INTO `users` (`id`, `email`, `password`, `created_at`, `is_activated`, `activated_at`, `is_deleted`, `deleted_at`) VALUES (2,'deleted@user.com','anotherHashedPassword','2022-11-01 19:17:07',0,'2022-11-01 19:17:14',1,'2022-11-01 20:17:20');

-- Create table: `user_details`

CREATE TABLE `user_details` (
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'User details table''s unique id',
    `user_id` int NOT NULL COMMENT 'User''s details table''s parent id',
    `name` varchar(255) NOT NULL COMMENT 'User''s name',
    `last_name` varchar(255) NOT NULL COMMENT 'User''s last name',
    `mobile_number` varchar(20) DEFAULT NULL COMMENT 'User''s mobile phone number',
    `mobile_number_verified_at` datetime DEFAULT NULL COMMENT 'User''s mobile phone number verification date time',
    PRIMARY KEY (`id`),
    UNIQUE KEY `id` (`id`),
    UNIQUE KEY `user_id` (`user_id`),
    CONSTRAINT `user_details_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='User details table';

-- Insert data to: `user_details`

INSERT INTO `user_details` (`id`, `user_id`, `name`, `last_name`, `mobile_number`, `mobile_number_verified_at`) VALUES (2,1,'Ayhan','Polat','(737) 288 5944','2022-11-01 19:15:50');
INSERT INTO `user_details` (`id`, `user_id`, `name`, `last_name`, `mobile_number`, `mobile_number_verified_at`) VALUES (3,2,'Deleted','User','(123) 456 7890','2022-11-01 19:18:05');

-- Create table: `user_role_in_companies`

CREATE TABLE `user_role_in_companies` (
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'User''s role unique id',
    `user_id` int NOT NULL COMMENT 'Role''s user id. user_id and company_id cannot have the same values on the same line.',
    `company_id` int NOT NULL COMMENT 'Role''s company id. user_id and company_id cannot have the same values on the same line.',
    `role` enum('Admin','Editor','Reviewer') DEFAULT NULL COMMENT 'User''s role in company. It is enum (but if we want create table for roles table and foreign key with this column)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `id` (`id`),
    UNIQUE KEY `user_role_in_companies_user_id_company_id_uindex` (`user_id`,`company_id`),
    KEY `user_role_in_companies_companies_id_fk` (`company_id`),
    CONSTRAINT `user_role_in_companies_companies_id_fk` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `user_role_in_companies_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='The role of the user in companies table';

-- Insert data to: `user_role_in_companies`

INSERT INTO `user_role_in_companies` (`id`, `user_id`, `company_id`, `role`) VALUES (2,1,1,'Admin');
INSERT INTO `user_role_in_companies` (`id`, `user_id`, `company_id`, `role`) VALUES (3,1,2,'Editor');
INSERT INTO `user_role_in_companies` (`id`, `user_id`, `company_id`, `role`) VALUES (6,2,1,'Editor');
INSERT INTO `user_role_in_companies` (`id`, `user_id`, `company_id`, `role`) VALUES (7,2,2,'Reviewer');

-- PROCESS COMPLETED