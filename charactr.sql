
create table users (
  id int not null auto_increment primary key,
  email varchar(128),
  password varchar(64),
  name varchar(64)
);
create table campaigns (
  id int not null auto_increment primary key,
  name varchar(64),
  created_by_user_id tinyint
);
create table roles (
  id int not null auto_increment primary key,
  name varchar(64)
);
insert into roles (name) values ('DM');
insert into roles (name) values ('PC');

create table users_campaigns(
  id int not null auto_increment primary key,
  user_id int,
  campaign_id int,
  role_id int
);
create table characters (
  id int not null auto_increment primary key,
  user_id int,  
  name varchar(64),
  sex enum('M', 'F'),
  class_id tinyint,
  race_id tinyint,
  experience_points int,
  level tinyint,
  max_hit_points tinyint,
  current_hit_points tinyint,
  healing_surge tinyint,
  surges_per_day tinyint,
  surges_remaining tinyint,
  action_points tinyint,
  initiative tinyint,
  armor_class tinyint,
  misc_fortitude_bonus tinyint,
  misc_reflex_bonus tinyint,
  misc_will_bonus tinyint,
  height varchar(8),
  weight tinyint,
  alignment enum('good', 'lawful good', 'evil', 'chaotic evil', 'unaligned'),
  strength tinyint,
  constitution tinyint,
  dexterity tinyint,
  intellegence tinyint,
  wisdom tinyint,
  charisma tinyint

);


create table classes (
  id int not null auto_increment primary key,
  name varchar(32),
  fortitude_def_bonus int,
  reflex_def_bonus int,
  will_def_bonus int
);
insert into classes (name, fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('cleric', 0, 0, 2);
insert into classes (name, fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('fighter',2,0,0);
insert into classes (name, fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('paladin',1,1,1);
insert into classes (name,fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('ranger',1,1,0);
insert into classes (name, fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('rogue',0,2,0);
insert into classes (name,fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('warlock',0,1,1);
insert into classes (name,fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('warlord',1,0,1);
insert into classes (name,fortitude_def_bonus, reflex_def_bonus, will_def_bonus) values ('wizard',0,0,2);

create table races (
  id int not null auto_increment primary key,
  name varchar(64),
  speed tinyint,
  size enum('small', 'medium', 'large'),
  vision enum('normal', 'low-light')
);
insert into races (name, speed, size, vision) values ('Dragonborn', 6, 'medium', 'normal');
insert into races (name, speed, size, vision) values ('Dwarf', 5, 'medium', 'low-light');
insert into races (name, speed, size, vision) values ('Eladrin', 6, 'medium', 'low-light');
insert into races (name, speed, size, vision) values ('Elf', 7, 'medium', 'low-light');
insert into races (name, speed, size, vision) values ('Half-elf', 6, 'medium', 'low-light');
insert into races (name, speed, size, vision) values ('Halfling', 6, 'small', 'normal');
insert into races (name, speed, size, vision) values ('Human', 6, 'medium', 'normal');
insert into races (name, speed, size, vision) values ('Tiefling', 6, 'medium', 'low-light');


create table skills (
  id int not null auto_increment primary key,
  name varchar(32),
  key_ability varchar(32)
);


insert into skills (name, key_ability) values ('Acrobatics', 'Dexterity'); 
insert into skills (name, key_ability) values ('Arcana', 'Intellegence'); 
insert into skills (name, key_ability) values ('Athletics', 'Strength'); 
insert into skills (name, key_ability) values ('Bluff', 'Charisma'); 
insert into skills (name, key_ability) values ('Diplomacy', 'Charisma'); 
insert into skills (name, key_ability) values ('Dungeoneering', 'Wisdom'); 
insert into skills (name, key_ability) values ('Endurance', 'Constitution'); 
insert into skills (name, key_ability) values ('Heal', 'Wisdom'); 
insert into skills (name, key_ability) values ('History', 'Intellegence'); 
insert into skills (name, key_ability) values ('Insight', 'Wisdom'); 
insert into skills (name, key_ability) values ('Intimidate', 'Charisma'); 
insert into skills (name, key_ability) values ('Nature', 'Wisdom'); 
insert into skills (name, key_ability) values ('Perception', 'Wisdom'); 
insert into skills (name, key_ability) values ('Religion', 'Intellegence'); 
insert into skills (name, key_ability) values ('Stealth', 'Dexterity'); 
insert into skills (name, key_ability) values ('Streetwise', 'Charisma'); 
insert into skills (name, key_ability) values ('Thievery', 'Dexterity'); 

create table character_skills (
	id int not null auto_increment primary key,
	character_id int not null,
	skill_id int not null,
	trained bool,
	misc_bonus int,
	misc_bonus_description varchar(64)
);

create table feats (
  id int not null auto_increment primary key,
  character_id int not null,
  name varchar(32),
  description varchar(128),
  level_gained_at int 
);

create table powers (
  id int not null auto_increment primary key,
  character_id int not null,
  name varchar(32),
  description varchar(128),
  frequency enum('at-will', 'encounter', 'daily'),
  level_gained_at int 
);

create table weapons (
  id int not null auto_increment primary key,
  character_id int not null,
  name varchar(32),
  description varchar(128),
  key_ability varchar(32)
);


