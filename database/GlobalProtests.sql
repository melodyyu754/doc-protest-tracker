
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


DROP SCHEMA IF EXISTS GlobalProtests;
CREATE SCHEMA IF NOT EXISTS GlobalProtests;


USE GlobalProtests;

CREATE TABLE if not exists cause (
    cause_id INT UNIQUE NOT NULL,
    cause_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (cause_id)
);

CREATE TABLE if not exists country (
    year INT,
    country VARCHAR(80) UNIQUE NOT NULL,
    protests_per_capita FLOAT, 
    population INT,
    gdp_per_capita FLOAT,
    unemployment_rate FLOAT,
    urbanization_rate FLOAT,
    inflation_rate FLOAT,
    PRIMARY KEY(country)
);

CREATE TABLE if not exists users (
    user_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    country VARCHAR(80) NOT NULL,
    user_type VARCHAR(20) NOT NULL,
    party VARCHAR(80),
    FOREIGN KEY (country) references country(country),
    PRIMARY KEY(user_id)
);

CREATE TABLE if not exists protests (
    protest_id INT UNIQUE NOT NULL,
    location VARCHAR(80) NOT NULL,
    date DATE NOT NULL,
    description TEXT,
    violent BOOL NOT NULL,
    created_by INT,
    country VARCHAR(80) NOT NULL,
    cause INT NOT NULL,
    longitude FLOAT NOT NULL,
    latitude FLOAT NOT NULL,
    PRIMARY KEY (protest_id),
    FOREIGN KEY (created_by) references users(user_id),
    FOREIGN KEY (country) references country(country),
    FOREIGN KEY (cause) references cause(cause_id)
);


CREATE TABLE if not exists news_articles (
    news_id INT UNIQUE NOT NULL,
    article_name VARCHAR(100) NOT NULL,
    author_first_name VARCHAR(50) NOT NULL,
    author_last_name VARCHAR(50) NOT NULL,
    publication_date DATE,
    source VARCHAR(80),
    PRIMARY KEY (news_id)
);

CREATE TABLE if not exists posts (
    post_id INT UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    creation_date DATE NOT NULL,
    text TEXT,
    created_by INT NOT NULL,
    cause INT NOT NULL,
    PRIMARY KEY(post_id),
    FOREIGN KEY (created_by) references users(user_id),
    FOREIGN KEY (cause) references cause(cause_id)
);

CREATE TABLE if not exists comments (
    comment_id INT UNIQUE NOT NULL,
    created_by INT NOT NULL,
    post INT NOT NULL,
    text TEXT NOT NULL,
    created_at DATE,
    FOREIGN KEY (post) references posts(post_id) ON DELETE CASCADE,
    PRIMARY KEY (comment_id) # --not sure why i had post and comment_id as a double primary key?
);

CREATE TABLE if not exists protest_attendence (
    user INT,
    protest INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (protest) references protests(protest_id) ON DELETE CASCADE
);

CREATE TABLE if not exists protest_likes (
    user INT,
    protest INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (protest) references protests(protest_id) ON DELETE CASCADE
);

CREATE TABLE if not exists news_likes(
    user INT,
    news_article INT,
    FOREIGN KEY (user) references users(user_id),
    FOREIGN KEY (news_article) references news_articles(news_id)
);

CREATE TABLE if not exists user_interests (
    user INT,
    interests VARCHAR(100),
    FOREIGN KEY (user) references users(user_id)
);

INSERT INTO cause (cause_id, cause_name) VALUES ('1', 'Racial Inequality');
INSERT INTO cause (cause_id, cause_name) VALUES ('2', 'Climate Change');
INSERT INTO cause (cause_id, cause_name) VALUES ('3', 'Political Corruption');
INSERT INTO cause (cause_id, cause_name) VALUES ('4', 'Gender Equality');
INSERT INTO cause (cause_id, cause_name) VALUES ('5', 'Animal Rights');
INSERT INTO cause (cause_id, cause_name) VALUES ('6', 'Black Lives Matter');
INSERT INTO cause (cause_id, cause_name) VALUES ('7', 'Israeli-Palestine');

INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Albania', '52.92169137725642', '2777689', '6810.11404104233', '11.629', '63.799', '131.750834819418');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Argentina', '53.401299409990266', '46234830', '13650.6046294524', '6.805', '92.347', NULL);
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Australia', '30.531955883246415', '26005540', '65099.8459118981', '3.7', '86.488', '132.466181061394');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Austria', '32.51546613630329', '9041851', '52084.6811953372', '4.99', '59.256', '133.513565675464');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Belgium', '44.7551193267324', '11685814', '49926.8254295305', '5.56', '98.153', '132.456219048303');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Brazil', '17.314288396354975', '215313498', '8917.67491057495', '9.23', '87.555', '204.482120615775');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Bulgaria', '93.5794157458117', '6465097', '13974.4492487792', '4.27', '76.363', '138.584408106261');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Canada', '46.956193211069476', '38929902', '55522.445687688', '5.28', '81.752', '129.858328563251');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Chile', '47.28691214066219', '19603733', '15355.4797401048', '8.25', '87.912', '158.625026875941');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Colombia', '26.29447061982313', '51874024', '6624.16539269075', '10.55', '82.05', '164.780806314133');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Costa Rica', '31.65516561152665', '5180829', '13365.3563992692', '11.32', '82.042', '142.944768574546');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Croatia', '28.789293495175848', '3855600', '18570.4039968345', '6.96', '58.219', '124.955261274159');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Denmark', '62.84900467335713', '5903037', '67790.0539923276', '4.43', '88.367', '121.55164717436');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Estonia', '54.86195545802319', '1348840', '28247.095992497', '5.57', '69.609', '151.94333206325');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Finland', '62.09384774156577', '5556106', '50871.9304508821', '6.72', '85.681', '123.331790076698');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'France', '94.46632565318623', '67971311', '40886.2532680273', '7.31', '81.509', '118.258283622798');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Germany', '56.9226097739701', '83797985', '48717.9911402128', '3.14', '77.648', '124.489744387368');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Greece', '41.623033611366886', '10426919', '20867.2690861087', '12.43', '80.357', '111.738622172264');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Hungary', '43.03618523935586', '9643048', '18390.1849993244', '3.61', '72.552', '151.411885949845');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Iceland', '73.29785368177737', '382003', '73466.7786674708', '3.79', '93.992', '150.087495958498');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'India', '10.321250979537135', '1417173173', '2410.88802070689', '4.822', '35.872', '205.266241146235');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Indonesia', '11.13969177478299', '275501339', '4787.99930771921', '3.46', '57.934', '163.071752418121');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Ireland', '54.415983866343424', '5127170', '103983.29133582', '4.48', '64.183', '117.221883969731');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Israel', '77.11221553753597', '9557500', '54930.9388075096', '3.695', '92.763', '113.939796790428');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Italy', '77.94310950421549', '58940425', '34776.423234274', '8.07', '71.657', '121.771084752039');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Jamaica', '38.90531754343337', '2827377', '6047.2164567796', '5.499', '57.008', '199.742721733243');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Japan', '12.659341772249826', '125124989', '34017.2718075024', '2.6', '91.955', '107.839690631042');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Kosovo', '74.91550722622496', '1761985', '5340.26879794836', NULL , NULL, '136.426245250384');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Latvia', '25.008207480859408', '1879383', '21779.5042572825', '6.81', '68.54', '141.886081804437');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Lithuania', '26.83957948029392', '2831639', '25064.808914729', '5.96', '68.465', '150.12636507601');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Luxembourg', '50.52801778586226', '653103', '125006.021815486', '4.58', '91.881', '126.501046501047');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Malta', '152.5099178517566', '531113', '34127.5105566356', '2.92', '94.875', '123.018580023951');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Mexico', '47.20631587409427', '127504125', '11496.5228716049', '3.26', '81.3', '166.890369321443');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Mongolia', '37.66516025642912', '3398366', '5045.50470031666', '6.21', '68.93', '251.172516573854');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Netherlands', '39.88479283239766', '17700982', '57025.01245598', '3.52', '92.886', '132.577542831667');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Norway', '88.32486398062571', '5457127', '108729.18690323', '3.23', '83.664', '133.32730069677');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Philippines', '2.327815047288957', '115559009', '3498.5098055874', '2.375', '47.977', '145.965868357034');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Poland', '31.28585771414606', '36821749', '18688.0044867103', '2.89', '60.134', '141.807246589409');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Portugal', '31.797253793191434', '10409704', '24515.2658507319', '6.01', '67.381', '120.783990313085');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Romania', '10.815346388506457', '19047009', '15786.8017421977', '5.61', '54.489', '151.866303747835');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Serbia', '57.01896735949213', '6664449', '9537.68286673128', '8.684', '56.873', '170.482256596906');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Singapore', '0.7095945341352224', '5637022', '82807.6290622897', '3.59', '100.0', '123.980978131334');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Slovenia', '30.303231176721816', '2111986', '28439.3340989687', '4.01', '55.751', '123.110404802896');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Spain', '79.86882759007533', '47778340', '29674.5442864413', '12.92', '81.304', '123.591728295232');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Sweden', '140.4604069003535', '10486941', '56424.2846986686', '7.39', '88.492', '122.957183435409');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Switzerland', '21.19474552631339', '8775760', '93259.9057183024', '4.3', '74.092', '102.21728177187');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Thailand', '4.672439011769386', '71697030', '6909.9562847948', '0.94', '52.889', '120.59868874216');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'United Kingdom', '26.055900433311862', '66971395', '46125.2557513568', '3.73', '84.398', '133.660070279268');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'United States', '36.55401992700256', '333287557', '76329.5822652029', '3.65', '83.084', '134.21120616846');
INSERT INTO country (year, country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate) VALUES ('2022', 'Uruguay', '31.5531697204097', '3422794', '20795.0423535553', '7.87', '95.688', '261.824349714601');

INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('1', 'Christen', 'Simacek', 'csimacek0@admin.ch', 'Sweden', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('2', 'Filippa', 'Irvin', 'firvin1@prnewswire.com', 'Israel', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('3', 'Gleda', 'Greenacre', 'ggreenacre2@networkadvertising.org', 'Uruguay', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('4', 'Julieta', 'Ballantine', 'jballantine3@moonfruit.com', 'Philippines', 'Politician', 'Democratic');
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('5', 'Fay', 'Sallenger', 'fsallenger4@odnoklassniki.ru', 'Finland', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('6', 'Bartel', 'Valder', 'bvalder5@1und1.de', 'Slovenia', 'Activist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('7', 'Lyn', 'Nuschke', 'lnuschke6@merriam-webster.com', 'Jamaica', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('8', 'Nariko', 'MacGlory', 'nmacglory7@hao123.com', 'Jamaica', 'Politician', 'Democratic');
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('9', 'Sheff', 'Baskett', 'sbaskett8@about.me', 'Costa Rica', 'Journalist', NULL);
INSERT INTO users (user_id, first_name, last_name, email, country, user_type, party) VALUES ('10', 'Ronald', 'Davion', 'rdavion9@ibm.com', 'Poland', 'Activist', NULL);

INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('1', 'Panggungsari', '2024-01-19', 'Nullam varius. Nulla facilisi.', '0', NULL, 'Malta', '5', '111.813634', '-8.1265731');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('2', 'Chotcza', '2020-03-27', 'Morbi porttitor lorem id ligula.', '1', NULL, 'Germany', '4', '21.4274273', '51.1227795');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('3', 'Changjiang', '2021-12-02', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '1', '2', 'Ireland', '6', '112.8915932', '30.5211502');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('4', 'Burunday', '2022-10-20', 'Morbi non lectus.', '0', '3', 'Denmark', '1', '76.840271', '43.32756');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('5', 'Usa River', '2019-02-19', 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '1', NULL, 'Italy', '4', '36.8398354', '-3.380978');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('6', 'Pesucen', '2022-06-30', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '0', NULL, 'Brazil', '6', '114.3014572', '-8.1574988');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('7', 'Leninogorsk', '2022-05-27', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '0', NULL, 'Brazil', '2', '52.4387134', '54.6001467');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('8', 'Grindavík', '2021-01-30', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '1', '6', 'Albania', '6', '-22.410284', '63.839604');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('9', 'Puerto Galera', '2019-07-29', 'Proin at turpis a pede posuere nonummy.', '0', NULL, 'Sweden', '7', '120.9617948', '13.5218669');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('10', 'Zarechnyy', '2019-01-15', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '0', '4', 'Austria', '5', '73.328393', '54.982808');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('11', 'Hengliang', '2021-08-08', 'Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '0', NULL, 'Iceland', '1', '118.930364', '32.31876');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('12', 'Magisterial', '2020-01-15', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '1', NULL, 'Mexico', '7', '-99.110685', '19.2949759');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('13', 'Dawan', '2021-04-29', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', '5', 'Ireland', '1', '115.4378152', '-8.5435854');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('14', 'Borås', '2021-11-11', 'Vivamus tortor.', '0', NULL, 'Romania', '3', '12.933356', '57.7197857');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('15', 'Sofádes', '2020-02-24', 'In congue. Etiam justo.', '0', '4', 'Hungary', '4', '22.097651', '39.335659');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('16', 'Lichinga', '2022-06-18', 'Quisque ut erat. Curabitur gravida nisi at nibh.', '1', '4', 'Brazil', '2', '35.2478112', '-13.3023564');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('17', 'Värnamo', '2021-06-22', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '0', NULL, 'Malta', '7', '14.0338655', '57.2033415');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('18', 'Kálymnos', '2021-03-08', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '1', NULL, 'Netherlands', '3', '26.9807653', '36.9522824');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('19', 'Szolnok', '2022-06-04', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '1', NULL, 'Australia', '7', '20.1974097', '47.1594836');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('20', 'Kasakh', '2021-07-08', 'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '0', '10', 'Spain', '5', '44.4514419', '40.2355256');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('21', 'Saint-Étienne', '2023-07-08', 'Praesent blandit lacinia erat.', '1', NULL, 'Belgium', '6', '4.3637137', '45.4815563');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('22', 'Ōnojō', '2023-12-04', 'Aliquam erat volutpat.', '0', NULL, 'India', '1', '137.0770574', '34.8383901');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('23', 'Yulin', '2024-02-25', 'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '1', '1', 'Mexico', '7', '110.18122', '22.654032');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('24', 'Galyugayevskaya', '2021-04-14', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '0', NULL, 'Brazil', '3', '44.93444', '43.69694');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('25', 'Toupi', '2019-08-12', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', '1', '8', 'Portugal', '6', '116.19359', '26.751281');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('26', 'Gon’ba', '2022-10-02', 'Mauris sit amet eros.', '1', '4', 'Serbia', '2', '83.5779817', '53.4154689');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('27', 'Zhaowanzhuang', '2022-06-02', 'Morbi a ipsum. Integer a nibh. In quis justo.', '1', '5', 'Canada', '5', '116.087054', '35.242057');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('28', 'Ugac Sur', '2023-02-25', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '1', '10', 'Albania', '3', '121.7177272', '17.6102139');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('29', 'Rojas', '2020-02-10', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '0', NULL, 'Denmark', '2', '-58.4464356', '-34.6089515');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('30', 'Al Fūlah', '2019-11-21', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '0', '4', 'Singapore', '1', '28.3578828', '11.7315405');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('31', 'Paris La Défense', '2022-08-09', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '1', NULL, 'Denmark', '4', '2.233089', '48.892701');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('32', 'Nginokrajan', '2021-08-21', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '1', '2', 'Belgium', '7', '112.0647', '-6.9936');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('33', 'Jurak Lao’', '2019-03-18', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '1', '8', 'Estonia', '1', '109.325464', '-0.0142486');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('34', 'Sanhu', '2019-09-01', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '0', NULL, 'Colombia', '2', '113.6710978', '23.2008019');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('35', 'Mirimire', '2023-01-09', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', '0', NULL, 'Thailand', '3', '-68.7259306', '11.1626327');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('36', 'Morón', '2020-03-23', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '0', NULL, 'Estonia', '5', '-78.6228504', '22.0897108');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('37', 'Kalej', '2020-11-15', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '1', NULL, 'Greece', '6', '-80.6150117', '41.0213628');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('38', 'Pridonskoy', '2019-01-01', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.', '0', NULL, 'Ireland', '7', '39.0891762', '51.6521236');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('39', 'Paris 19', '2023-04-19', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '1', '1', 'Albania', '1', '5.8978018', '43.4945737');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('40', 'Américo Brasiliense', '2020-12-28', 'Duis mattis egestas metus.', '0', '3', 'Mexico', '5', '-48.0605108', '-21.7300823');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('41', 'Suchy Dąb', '2020-03-17', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '1', NULL, 'United Kingdom', '7', '18.7647749', '54.2315533');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('42', 'Sayama', '2023-03-11', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', '0', NULL, 'Japan', '3', '131.3494901', '34.0313411');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('43', 'Khao Kho', '2021-06-10', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '1', '5', 'United Kingdom', '6', '101.0118776', '16.6482598');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('44', 'General Pinedo', '2023-10-20', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', NULL, 'Serbia', '4', '-58.3762722', '-34.679347');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('45', 'Baima', '2023-03-11', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', '7', 'Italy', '1', '104.990101', '29.528923');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('46', 'Paipu', '2023-07-17', 'Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '1', NULL, 'Kosovo', '4', '116.342934', '22.980665');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('47', 'São João de Caparica', '2019-02-16', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '0', NULL, 'Philippines', '2', '-9.2406619', '38.661678');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('48', 'Krajan Gajihan', '2020-02-02', 'Aliquam non mauris. Morbi non lectus.', '1', NULL, 'Singapore', '3', '110.6013327', '-7.6185371');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('49', 'Los Palacios', '2023-10-21', 'Pellentesque at nulla.', '1', NULL, 'Serbia', '7', '-83.2425711', '22.588115');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('50', 'Huichang', '2023-01-31', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '1', '1', 'Latvia', '5', '115.786056', '25.600272');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('51', 'Riachos', '2019-01-19', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '1', '6', 'France', '3', '-8.5116903', '39.4381452');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('52', 'Vellinge', '2024-03-28', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '1', NULL, 'Ireland', '3', '12.9658307', '55.496478');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('53', 'San Juan', '2021-06-26', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '0', NULL, 'Finland', '7', '121.0317737', '14.565668');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('54', 'Carrascal', '2019-01-24', 'Morbi a ipsum. Integer a nibh.', '1', NULL, 'Luxembourg', '2', '-7.9808794', '39.7213971');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('55', 'Sakura', '2021-12-28', 'Donec ut mauris eget massa tempor convallis.', '0', NULL, 'Jamaica', '4', '140.8706157', '38.1086472');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('56', 'Kapsan-ŭp', '2019-01-07', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '0', '7', 'United States', '6', '128.29333', '41.09028');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('57', 'Ikar', '2023-02-14', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '1', NULL, 'Mongolia', '1', '115.2402986', '-8.615202');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('58', 'Chakaray', '2021-11-28', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '0', NULL, 'Israel', '6', '69.4377', '34.34099');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('59', 'Matnah', '2022-03-08', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '1', NULL, 'Italy', '7', '44.0270562', '15.2525945');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('60', 'Zabłocie', '2020-03-21', 'Nullam molestie nibh in lectus.', '0', NULL, 'Singapore', '1', '16.611189', '51.0610829');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('61', 'Ji’ergele Teguoleng', '2023-06-05', 'Nullam molestie nibh in lectus.', '0', NULL, 'Latvia', '3', '84.17916', '44.35542');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('62', 'Yengimahalla', '2023-03-09', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '1', '6', 'Norway', '6', '82.63142', '41.356361');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('63', 'Vynohradiv', '2022-05-16', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '0', '4', 'Switzerland', '1', '23.0302123', '48.1463491');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('64', 'Calçada', '2021-08-11', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '0', NULL, 'Italy', '6', '-8.6450785', '42.0328151');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('65', 'Stockholm', '2023-11-25', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '1', NULL, 'Canada', '1', '18.0667759', '59.3405742');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('66', 'Vancouver', '2021-07-19', 'Nulla ut erat id mauris vulputate elementum.', '0', '2', 'Hungary', '3', '-122.52', '45.63');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('67', 'Ruoqiang', '2023-11-07', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '1', NULL, 'United Kingdom', '1', '88.166695', '39.024258');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('68', 'Nuštar', '2020-04-02', 'Nulla tellus. In sagittis dui vel nisl.', '0', '1', 'Hungary', '4', '18.8818902', '45.3098715');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('69', 'Yuzhou', '2019-05-10', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '1', NULL, 'Philippines', '5', '120.585289', '31.298974');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('70', 'Mirów', '2020-10-01', 'Phasellus in felis. Donec semper sapien a libero.', '1', NULL, 'Ireland', '7', '19.46436', '50.614436');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('71', 'Welkom', '2024-05-17', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '1', NULL, 'Kosovo', '5', '26.77027', '-27.9699645');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('72', 'Zawichost', '2021-02-04', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', '1', NULL, 'Portugal', '3', '21.8528832', '50.8075698');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('73', 'Bordeaux', '2023-01-15', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '1', NULL, 'Spain', '5', '-0.5494198', '44.8445542');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('74', 'Yangjiapo', '2023-08-14', 'Aliquam erat volutpat. In congue. Etiam justo.', '0', NULL, 'Norway', '1', '111.982232', '21.857958');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('75', 'Dayr Abū Ḑa‘īf', '2021-05-02', 'Nam tristique tortor eu pede.', '0', NULL, 'Portugal', '6', '35.364922', '32.456061');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('76', 'Sambava', '2022-03-13', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '1', '5', 'Albania', '7', '50.1678121', '-14.2713338');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('77', 'Kuznetsovs’k', '2019-01-01', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '0', NULL, 'Germany', '2', '25.8490867', '51.3436553');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('78', 'Madīnat ash Shamāl', '2019-01-30', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '0', NULL, 'Japan', '5', '51.3385684', '25.9210961');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('79', 'Rio Piracicaba', '2024-01-14', 'In sagittis dui vel nisl.', '1', NULL, 'Mongolia', '4', '-43.1359542', '-19.9661142');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('80', 'Zeerust', '2021-07-22', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', '0', '1', 'Albania', '7', '26.07191', '-25.5468699');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('81', 'Nishio', '2024-02-07', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', '3', 'Iceland', '1', '139.7874841', '37.4056028');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('82', 'Xushuguan', '2021-05-08', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '1', '4', 'Slovenia', '2', '121.4228893', '31.1429853');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('83', 'Golcowa', '2022-10-23', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '0', NULL, 'Norway', '1', '22.0252771', '49.7708764');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('84', 'Welisara', '2019-04-15', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '1', NULL, 'Austria', '5', '79.9020405', '7.0241972');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('85', 'Itumbiara', '2023-01-08', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '0', NULL, 'Austria', '7', '-49.2162908', '-18.4097245');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('86', 'Salt Lake City', '2023-01-28', 'Morbi ut odio.', '1', '4', 'Philippines', '4', '-111.94', '40.7');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('87', 'Paris 13', '2022-02-16', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '0', NULL, 'Uruguay', '3', '2.3757659', '48.8335842');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('88', 'Wadung', '2022-04-11', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', NULL, 'Belgium', '5', '111.9075351', '-7.0448624');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('89', 'Micheng', '2019-11-19', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', '0', '7', 'Kosovo', '6', '115.008163', '31.172739');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('90', 'Tongyuanpu', '2020-12-10', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', NULL, 'India', '7', '123.9253791', '40.796787');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('91', 'Haninge', '2022-06-15', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '0', '10', 'Japan', '5', '18.236243', '59.1743158');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('92', 'Matiguás', '2022-11-17', 'Sed accumsan felis.', '0', '3', 'Albania', '1', '-85.4607639', '12.8383201');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('93', 'Paraipaba', '2021-05-10', 'Donec vitae nisi.', '0', '4', 'Iceland', '7', '-39.1482174', '-3.4383637');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('94', 'Zhongxi', '2020-09-08', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '1', NULL, 'Israel', '5', '114.1237079', '22.5346419');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('95', 'Osório', '2022-08-28', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '1', NULL, 'India', '2', '-50.247365', '-29.899528');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('96', 'Gonghe', '2019-06-02', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '1', NULL, 'Romania', '4', '100.620031', '36.284107');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('97', 'Sanqiao', '2020-05-15', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '0', NULL, 'Uruguay', '3', '107.77215', '34.943098');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('98', 'Pugeran', '2020-09-09', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', '1', NULL, 'Belgium', '1', '110.7465164', '-7.7037789');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('99', 'Peyima', '2022-03-04', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '1', NULL, 'Indonesia', '6', '-11.044307', '8.7550575');
INSERT INTO protests (protest_id, location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('100', 'Jablonné nad Orlicí', '2019-08-29', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '0', NULL, 'Austria', '7', '16.6005976', '50.0296342');

INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('1', 'Rallying for Rights', '2024-02-24', 'Fusce posuere felis sed lacus.', '4', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('2', 'Gathering for Equality', '2023-06-13', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.', '5', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('3', 'Demanding Justice Now', '2023-03-15', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '2', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('4', 'Gathering for Equality', '2024-03-11', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('5', 'Rallying for Rights', '2023-05-12', 'Aenean sit amet justo.', '7', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('6', 'Gathering for Equality', '2023-11-25', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '10', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('7', 'Gathering for Equality', '2023-10-31', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '1', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('8', 'Gathering for Equality', '2023-09-04', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('9', 'Stand Up Against Oppression', '2024-04-01', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '7', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('10', 'Rallying for Rights', '2023-04-22', 'Aliquam sit amet diam in magna bibendum imperdiet.', '4', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('11', 'Peaceful Protest Strategies', '2023-03-07', 'Nullam porttitor lacus at turpis.', '10', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('12', 'Unity in Action', '2023-11-28', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', '7', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('13', 'Gathering for Equality', '2024-01-09', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '6', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('14', 'Protest Planning 101', '2023-02-19', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '5', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('15', 'Unity in Action', '2024-02-12', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '9', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('16', 'Gathering for Equality', '2024-05-31', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('17', 'Stand Up Against Oppression', '2023-11-09', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '10', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('18', 'Rallying for Rights', '2023-06-18', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.', '6', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('19', 'Inquiring Minds Unite', '2024-01-26', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('20', 'Inquiring Minds Unite', '2024-05-29', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '8', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('21', 'Demanding Justice Now', '2023-10-09', 'Duis ac nibh.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('22', 'Stand Up Against Oppression', '2023-03-01', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('23', 'Voices of Change', '2023-07-23', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('24', 'March Against Injustice', '2023-02-09', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('25', 'Demanding Justice Now', '2023-03-04', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('26', 'Stand Up Against Oppression', '2023-06-07', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('27', 'Rallying for Rights', '2024-04-14', 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.', '4', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('28', 'Voices of Change', '2024-02-28', 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '5', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('29', 'Peaceful Protest Strategies', '2023-07-07', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '1', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('30', 'Protest Planning 101', '2024-05-24', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('31', 'Inquiring Minds Unite', '2023-04-16', 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '6', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('32', 'March Against Injustice', '2024-02-09', 'Duis at velit eu est congue elementum.', '3', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('33', 'March Against Injustice', '2023-07-15', 'Nunc rhoncus dui vel sem.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('34', 'Protest Planning 101', '2024-01-18', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', '3', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('35', 'Peaceful Protest Strategies', '2023-01-25', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('36', 'Rallying for Rights', '2023-06-16', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('37', 'Unity in Action', '2023-04-28', 'Donec posuere metus vitae ipsum. Aliquam non mauris.', '6', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('38', 'Protest Planning 101', '2023-05-06', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('39', 'Inquiring Minds Unite', '2023-05-23', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '9', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('40', 'Gathering for Equality', '2024-04-25', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('41', 'Stand Up Against Oppression', '2023-06-06', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '5', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('42', 'Protest Planning 101', '2023-04-30', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '6', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('43', 'Inquiring Minds Unite', '2023-05-25', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', '10', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('44', 'Protest Planning 101', '2024-04-02', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('45', 'Stand Up Against Oppression', '2023-02-27', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('46', 'Voices of Change', '2023-07-16', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '6', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('47', 'Peaceful Protest Strategies', '2024-04-01', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '8', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('48', 'Voices of Change', '2024-05-28', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('49', 'Gathering for Equality', '2023-01-05', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('50', 'Inquiring Minds Unite', '2024-05-09', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '8', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('51', 'Peaceful Protest Strategies', '2024-05-01', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '7', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('52', 'Protest Planning 101', '2023-04-09', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '1', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('53', 'Unity in Action', '2023-05-23', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '10', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('54', 'Peaceful Protest Strategies', '2023-05-11', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '4', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('55', 'Inquiring Minds Unite', '2024-02-05', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('56', 'Stand Up Against Oppression', '2023-12-06', 'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('57', 'March Against Injustice', '2023-03-30', 'Nulla facilisi.', '2', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('58', 'March Against Injustice', '2023-04-10', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '9', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('59', 'Rallying for Rights', '2023-06-05', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('60', 'Peaceful Protest Strategies', '2023-08-27', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.', '4', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('61', 'Protest Planning 101', '2023-08-19', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '10', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('62', 'Gathering for Equality', '2024-05-02', 'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc.', '9', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('63', 'Demanding Justice Now', '2024-02-05', 'Phasellus sit amet erat.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('64', 'Unity in Action', '2023-06-11', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('65', 'Rallying for Rights', '2023-03-18', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('66', 'Inquiring Minds Unite', '2024-02-09', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('67', 'Peaceful Protest Strategies', '2023-01-18', 'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('68', 'Inquiring Minds Unite', '2023-03-28', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('69', 'Inquiring Minds Unite', '2024-01-09', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('70', 'Voices of Change', '2024-01-01', 'Suspendisse potenti.', '2', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('71', 'Stand Up Against Oppression', '2023-05-31', 'Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '6', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('72', 'Unity in Action', '2023-11-17', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '3', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('73', 'Stand Up Against Oppression', '2023-01-01', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('74', 'Voices of Change', '2024-03-01', 'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', '3', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('75', 'Voices of Change', '2023-06-22', 'Pellentesque at nulla.', '7', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('76', 'Stand Up Against Oppression', '2023-04-24', 'Proin eu mi.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('77', 'Inquiring Minds Unite', '2024-03-01', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('78', 'Inquiring Minds Unite', '2023-09-26', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', '1', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('79', 'Gathering for Equality', '2024-02-08', 'Integer tincidunt ante vel ipsum.', '9', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('80', 'Protest Planning 101', '2023-06-13', 'Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('81', 'Demanding Justice Now', '2023-06-14', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '10', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('82', 'March Against Injustice', '2024-01-08', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '10', '3');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('83', 'Rallying for Rights', '2023-02-20', 'Aliquam sit amet diam in magna bibendum imperdiet.', '6', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('84', 'Protest Planning 101', '2023-02-28', 'Aliquam quis turpis eget elit sodales scelerisque.', '5', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('85', 'Gathering for Equality', '2023-05-27', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', '9', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('86', 'Protest Planning 101', '2023-05-19', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '8', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('87', 'March Against Injustice', '2023-11-03', 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '6', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('88', 'Unity in Action', '2023-08-04', 'Proin risus. Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '9', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('89', 'Stand Up Against Oppression', '2024-04-13', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '2', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('90', 'Demanding Justice Now', '2024-01-12', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '10', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('91', 'March Against Injustice', '2023-01-29', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '3', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('92', 'Rallying for Rights', '2023-10-28', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.', '6', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('93', 'Gathering for Equality', '2023-02-14', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '4', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('94', 'Peaceful Protest Strategies', '2024-03-03', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '7', '7');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('95', 'Stand Up Against Oppression', '2024-02-10', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '6', '4');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('96', 'Peaceful Protest Strategies', '2023-09-28', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', '5', '5');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('97', 'Unity in Action', '2023-06-08', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', '8', '6');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('98', 'Stand Up Against Oppression', '2023-09-09', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '9', '2');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('99', 'Peaceful Protest Strategies', '2023-06-08', 'Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2', '1');
INSERT INTO posts (post_id, title, creation_date, text, created_by, cause) VALUES ('100', 'Inquiring Minds Unite', '2023-10-25', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.', '3', '3');

INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('1', '4', '68', 'Etiam justo.', '2021-01-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('2', '9', '92', 'Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', '2021-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('3', '7', '69', 'Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2023-10-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('4', '1', '95', 'Aenean lectus.', '2021-03-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('5', '10', '42', 'Suspendisse potenti.', '2023-08-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('6', '8', '72', 'Pellentesque eget nunc.', '2021-11-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('7', '4', '30', 'Etiam pretium iaculis justo.', '2020-06-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('8', '5', '52', 'Duis consequat dui nec nisi volutpat eleifend.', '2019-11-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('9', '10', '82', 'Fusce consequat.', '2019-07-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('10', '1', '97', 'Integer a nibh. In quis justo.', '2024-04-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('11', '3', '75', 'Nulla justo.', '2020-07-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('12', '7', '48', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', '2023-03-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('13', '10', '92', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', '2020-06-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('14', '6', '69', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2023-09-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('15', '2', '10', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2020-07-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('16', '3', '99', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '2022-10-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('17', '5', '65', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2021-11-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('18', '7', '15', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '2020-05-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('19', '3', '47', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2023-04-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('20', '4', '87', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.', '2019-01-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('21', '5', '16', 'Integer tincidunt ante vel ipsum.', '2021-01-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('22', '9', '49', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', '2023-07-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('23', '2', '23', 'In sagittis dui vel nisl.', '2021-06-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('24', '1', '21', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2021-01-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('25', '5', '49', 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst.', '2023-08-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('26', '10', '51', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '2024-01-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('27', '7', '53', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '2019-10-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('28', '2', '2', 'Duis aliquam convallis nunc.', '2019-01-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('29', '9', '37', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '2019-07-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('30', '4', '91', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', '2021-12-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('31', '4', '30', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2020-11-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('32', '2', '14', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2023-08-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('33', '5', '10', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '2023-10-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('34', '8', '39', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '2023-07-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('35', '7', '32', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '2020-03-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('36', '9', '4', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2024-04-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('37', '10', '91', 'Nulla ut erat id mauris vulputate elementum.', '2023-01-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('38', '9', '61', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2021-09-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('39', '1', '20', 'Nulla nisl.', '2021-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('40', '4', '64', 'Ut tellus.', '2021-07-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('41', '6', '4', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2020-03-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('42', '5', '23', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '2020-03-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('43', '8', '79', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', '2023-04-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('44', '5', '57', 'Nulla tellus.', '2019-07-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('45', '2', '68', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2019-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('46', '9', '64', 'Suspendisse potenti.', '2023-01-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('47', '3', '55', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2023-09-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('48', '6', '37', 'Sed ante.', '2019-02-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('49', '2', '49', 'Cras in purus eu magna vulputate luctus.', '2019-01-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('50', '6', '42', 'In hac habitasse platea dictumst.', '2023-07-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('51', '4', '28', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2019-01-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('52', '9', '95', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.', '2020-12-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('53', '10', '22', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2020-03-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('54', '3', '50', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2019-12-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('55', '7', '58', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2021-08-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('56', '2', '43', 'Quisque porta volutpat erat.', '2022-10-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('57', '6', '100', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', '2020-09-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('58', '1', '3', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', '2020-09-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('59', '3', '99', 'Pellentesque ultrices mattis odio. Donec vitae nisi.', '2020-05-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('60', '8', '57', 'Donec posuere metus vitae ipsum.', '2021-07-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('61', '1', '19', 'In congue.', '2019-01-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('62', '6', '29', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2021-05-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('63', '3', '60', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2023-09-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('64', '7', '67', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', '2021-09-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('65', '8', '36', 'Morbi ut odio.', '2020-11-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('66', '4', '33', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', '2021-10-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('67', '7', '76', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2020-08-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('68', '6', '74', 'Donec ut dolor.', '2019-01-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('69', '4', '50', 'In hac habitasse platea dictumst.', '2022-03-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('70', '2', '6', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2024-04-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('71', '1', '49', 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '2019-11-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('72', '5', '52', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2021-12-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('73', '9', '81', 'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.', '2020-02-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('74', '8', '40', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', '2022-06-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('75', '3', '87', 'Suspendisse potenti.', '2022-05-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('76', '5', '17', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', '2021-02-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('77', '10', '95', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.', '2022-02-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('78', '4', '100', 'Integer tincidunt ante vel ipsum.', '2020-10-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('79', '10', '34', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '2019-10-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('80', '4', '67', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2023-11-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('81', '1', '46', 'Integer tincidunt ante vel ipsum.', '2022-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('82', '6', '44', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', '2023-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('83', '9', '10', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '2022-06-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('84', '2', '92', 'Pellentesque at nulla. Suspendisse potenti.', '2022-02-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('85', '3', '15', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2021-04-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('86', '10', '6', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', '2020-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('87', '4', '4', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', '2020-01-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('88', '5', '70', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.', '2019-05-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('89', '7', '71', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', '2020-06-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('90', '8', '98', 'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', '2019-03-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('91', '7', '54', 'Nunc nisl.', '2023-06-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('92', '6', '26', 'Praesent blandit.', '2020-10-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('93', '2', '72', 'Aliquam quis turpis eget elit sodales scelerisque.', '2022-04-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('94', '5', '46', 'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.', '2019-07-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('95', '4', '61', 'Nunc purus.', '2019-05-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('96', '1', '31', 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '2021-04-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('97', '7', '22', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2019-02-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('98', '3', '78', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', '2019-03-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('99', '10', '97', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2020-05-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('100', '1', '18', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '2022-06-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('101', '4', '43', 'Sed ante. Vivamus tortor.', '2019-01-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('102', '5', '87', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2022-07-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('103', '1', '91', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', '2022-10-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('104', '7', '2', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '2020-09-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('105', '4', '10', 'Donec posuere metus vitae ipsum.', '2022-10-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('106', '8', '25', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl.', '2022-11-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('107', '6', '70', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque.', '2022-08-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('108', '3', '18', 'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2023-02-03');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('109', '8', '62', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2021-06-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('110', '1', '91', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', '2019-06-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('111', '4', '55', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2023-03-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('112', '5', '34', 'Fusce consequat. Nulla nisl.', '2019-10-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('113', '6', '31', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2021-08-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('114', '7', '73', 'Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', '2020-12-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('115', '3', '6', 'Aliquam non mauris.', '2023-02-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('116', '8', '98', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2023-10-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('117', '9', '19', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.', '2023-01-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('118', '2', '12', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2023-04-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('119', '4', '49', 'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '2023-09-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('120', '6', '77', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '2023-02-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('121', '1', '41', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2021-05-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('122', '7', '93', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2022-04-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('123', '10', '25', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2021-04-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('124', '6', '36', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2021-09-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('125', '9', '48', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2022-07-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('126', '8', '95', 'Curabitur at ipsum ac tellus semper interdum.', '2022-02-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('127', '3', '2', 'Maecenas tincidunt lacus at velit.', '2022-02-16');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('128', '8', '70', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2023-03-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('129', '4', '86', 'Sed accumsan felis.', '2019-06-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('130', '10', '5', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', '2022-12-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('131', '6', '80', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', '2019-09-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('132', '5', '60', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2021-08-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('133', '1', '21', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '2020-01-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('134', '10', '36', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2019-01-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('135', '8', '40', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', '2020-06-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('136', '6', '53', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat.', '2020-03-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('137', '7', '74', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '2019-11-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('138', '4', '58', 'Curabitur gravida nisi at nibh.', '2019-08-25');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('139', '6', '88', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', '2021-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('140', '7', '48', 'Donec posuere metus vitae ipsum.', '2019-12-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('141', '9', '26', 'Integer ac leo.', '2022-11-21');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('142', '3', '70', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.', '2020-10-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('143', '5', '61', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2023-01-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('144', '2', '53', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2021-05-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('145', '9', '50', 'Nullam porttitor lacus at turpis.', '2019-11-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('146', '7', '86', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.', '2023-11-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('147', '2', '47', 'In eleifend quam a odio. In hac habitasse platea dictumst.', '2019-01-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('148', '10', '36', 'Etiam justo. Etiam pretium iaculis justo.', '2019-07-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('149', '4', '97', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2023-11-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('150', '5', '20', 'Ut tellus.', '2020-06-18');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('151', '4', '21', 'Morbi porttitor lorem id ligula.', '2022-06-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('152', '10', '10', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2024-03-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('153', '1', '46', 'Nulla mollis molestie lorem.', '2020-12-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('154', '2', '92', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-10-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('155', '9', '13', 'Proin at turpis a pede posuere nonummy. Integer non velit.', '2019-04-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('156', '3', '54', 'Proin eu mi. Nulla ac enim.', '2023-01-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('157', '2', '71', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '2019-10-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('158', '4', '40', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', '2023-02-20');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('159', '1', '96', 'In sagittis dui vel nisl.', '2022-10-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('160', '9', '51', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2022-04-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('161', '8', '99', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '2019-04-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('162', '6', '54', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', '2020-09-08');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('163', '8', '95', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '2021-01-02');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('164', '6', '80', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.', '2020-08-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('165', '4', '32', 'Curabitur in libero ut massa volutpat convallis.', '2020-07-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('166', '3', '94', 'In congue.', '2021-08-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('167', '5', '18', 'Proin risus.', '2020-08-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('168', '1', '12', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2022-06-23');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('169', '4', '37', 'In congue. Etiam justo.', '2023-04-29');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('170', '1', '20', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '2021-12-17');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('171', '8', '31', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2020-03-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('172', '2', '51', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante.', '2024-03-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('173', '5', '34', 'Praesent lectus.', '2023-01-31');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('174', '7', '93', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2019-04-12');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('175', '4', '64', 'Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.', '2020-07-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('176', '3', '35', 'Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat.', '2020-05-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('177', '6', '15', 'In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.', '2019-08-13');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('178', '5', '84', 'Pellentesque at nulla. Suspendisse potenti.', '2024-05-24');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('179', '2', '46', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', '2022-02-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('180', '9', '92', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', '2021-04-14');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('181', '10', '23', 'Aenean lectus. Pellentesque eget nunc.', '2022-09-30');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('182', '5', '17', 'Quisque id justo sit amet sapien dignissim vestibulum.', '2021-02-10');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('183', '2', '33', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2020-01-06');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('184', '3', '43', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', '2023-08-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('185', '1', '87', 'Duis bibendum.', '2022-10-19');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('186', '7', '21', 'Vestibulum ac est lacinia nisi venenatis tristique.', '2020-02-11');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('187', '5', '20', 'Morbi porttitor lorem id ligula.', '2021-08-01');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('188', '2', '76', 'Quisque ut erat. Curabitur gravida nisi at nibh.', '2019-12-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('189', '4', '45', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '2020-03-04');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('190', '6', '46', 'Aenean auctor gravida sem.', '2019-08-15');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('191', '1', '37', 'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', '2022-06-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('192', '3', '24', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', '2021-05-07');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('193', '8', '72', 'Nulla tellus.', '2019-05-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('194', '10', '97', 'Pellentesque viverra pede ac diam.', '2021-11-28');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('195', '9', '69', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-06-26');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('196', '7', '75', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', '2021-09-05');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('197', '6', '60', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', '2023-09-22');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('198', '10', '40', 'Donec posuere metus vitae ipsum. Aliquam non mauris.', '2022-07-27');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('199', '1', '47', 'Duis ac nibh.', '2021-10-09');
INSERT INTO comments (comment_id, created_by, post, text, created_at) VALUES ('200', '3', '30', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '2020-01-31');

INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('1', 'March for Justice', 'Hermy', 'Cassie', '2022-12-01', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('2', 'Voices of Change', 'Denny', 'Britee', '2016-04-20', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('3', 'Protest Perspectives', 'Melanie', 'Meak', '2017-11-29', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('4', 'Rally Reflections', 'Robinette', 'Hann', '2018-11-07', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('5', 'Activism Chronicles', 'Jephthah', 'Rawe', '2018-01-27', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('6', 'Rebellion Reports', 'Ramsay', 'Dryden', '2022-03-03', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('7', 'Demonstration Diaries', 'Starlin', 'Grenter', '2020-06-12', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('8', 'Revolution Reviews', 'Conni', 'Mathivon', '2017-05-05', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('9', 'Uprising Updates', 'Marlene', 'Tomaszczyk', '2021-03-20', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('10', 'Resistance Recaps', 'Nevsa', 'Keeney', '2022-11-12', 'The Sunday Times');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('11', 'Protest Pulse', 'Aurore', 'Paik', '2015-10-26', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('12', 'Marching Manifesto', 'Trefor', 'Poolton', '2015-03-09', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('13', 'Outcry Observations', 'Hyatt', 'Shurrock', '2016-12-24', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('14', 'Protestor Profiles', 'Esdras', 'Coultish', '2023-09-26', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('15', 'Protest Placards', 'Andrei', 'Lanfranchi', '2017-03-13', 'The Morning Post');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('16', 'Protest Poetry', 'Kaleena', 'Faichney', '2021-05-12', 'The Daily News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('17', 'Protest Power', 'Elbertina', 'O''Siaghail', '2023-08-28', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('18', 'Protest Platform', 'Chiquita', 'Durrad', '2021-12-02', 'The Weekly Herald');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('19', 'Protest Progress', 'Prue', 'Puleque', '2015-05-18', 'The Observer News');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('20', 'Protest Press', 'Richard', 'Marchant', '2021-10-13', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('21', 'March for Justice', 'Jake', 'Goding', '2022-05-10', 'The Chronicle Tribune');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('22', 'Voices of Change', 'Davide', 'Benedict', '2022-01-20', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('23', 'Protest Perspectives', 'Alard', 'Scarsbrick', '2020-02-15', 'The Evening Gazette');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('24', 'Rally Reflections', 'Quent', 'Martino', '2022-08-02', 'The Weekly Herald');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('25', 'Activism Chronicles', 'Juditha', 'Cajkler', '2023-09-05', 'The Gazette Express');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('26', 'Rebellion Reports', 'Mandi', 'Snar', '2020-07-12', 'The Press Journal');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('27', 'Demonstration Diaries', 'Lotta', 'Blaxley', '2017-09-09', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('28', 'Revolution Reviews', 'Dyna', 'McCoish', '2018-03-29', 'The Sentinel Sun');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('29', 'Uprising Updates', 'Dynah', 'Bailes', '2023-08-23', 'The Chronicle Tribune');
INSERT INTO news_articles (news_id, article_name, author_first_name, author_last_name, publication_date, source) VALUES ('30', 'Resistance Recaps', 'Webster', 'Ceaser', '2022-10-04', 'The Gazette Express');

INSERT INTO protest_attendence (user, protest) VALUES ('6', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '80');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '73');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '46');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '19');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '71');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '56');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '82');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '53');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '77');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '63');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '11');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '57');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '68');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '64');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '44');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '94');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '87');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '66');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '30');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '21');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '66');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '35');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '3');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '88');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '41');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '10');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '25');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '2');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '29');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '22');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '89');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '47');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '58');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '91');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '63');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '24');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '75');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '12');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '59');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '18');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '84');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '60');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '4');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '3');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '12');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '54');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '7');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '56');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '25');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '7');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '32');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '36');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '38');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '53');
INSERT INTO protest_attendence (user, protest) VALUES ('5', '42');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '99');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '13');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '17');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '48');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '16');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '43');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '94');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '34');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '27');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '32');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '16');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '89');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '74');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '91');
INSERT INTO protest_attendence (user, protest) VALUES ('2', '86');
INSERT INTO protest_attendence (user, protest) VALUES ('5', '23');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '21');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '76');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '77');
INSERT INTO protest_attendence (user, protest) VALUES ('3', '45');
INSERT INTO protest_attendence (user, protest) VALUES ('1', '72');
INSERT INTO protest_attendence (user, protest) VALUES ('9', '19');
INSERT INTO protest_attendence (user, protest) VALUES ('7', '55');
INSERT INTO protest_attendence (user, protest) VALUES ('10', '93');
INSERT INTO protest_attendence (user, protest) VALUES ('6', '8');
INSERT INTO protest_attendence (user, protest) VALUES ('4', '74');
INSERT INTO protest_attendence (user, protest) VALUES ('8', '27');

INSERT INTO protest_likes (user, protest) VALUES ('5', '72');
INSERT INTO protest_likes (user, protest) VALUES ('6', '31');
INSERT INTO protest_likes (user, protest) VALUES ('7', '99');
INSERT INTO protest_likes (user, protest) VALUES ('5', '55');
INSERT INTO protest_likes (user, protest) VALUES ('2', '28');
INSERT INTO protest_likes (user, protest) VALUES ('5', '91');
INSERT INTO protest_likes (user, protest) VALUES ('7', '35');
INSERT INTO protest_likes (user, protest) VALUES ('10', '50');
INSERT INTO protest_likes (user, protest) VALUES ('2', '96');
INSERT INTO protest_likes (user, protest) VALUES ('7', '50');
INSERT INTO protest_likes (user, protest) VALUES ('9', '86');
INSERT INTO protest_likes (user, protest) VALUES ('7', '72');
INSERT INTO protest_likes (user, protest) VALUES ('8', '3');
INSERT INTO protest_likes (user, protest) VALUES ('8', '74');
INSERT INTO protest_likes (user, protest) VALUES ('10', '93');
INSERT INTO protest_likes (user, protest) VALUES ('1', '27');
INSERT INTO protest_likes (user, protest) VALUES ('5', '17');
INSERT INTO protest_likes (user, protest) VALUES ('7', '47');
INSERT INTO protest_likes (user, protest) VALUES ('9', '59');
INSERT INTO protest_likes (user, protest) VALUES ('5', '56');

INSERT INTO user_interests (user, interests) VALUES ('5', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('2', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political violence');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('4', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'political reform');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('10', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('9', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political reform');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('1', 'legislation');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voting');
INSERT INTO user_interests (user, interests) VALUES ('9', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('4', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('7', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('4', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('1', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('10', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('3', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('6', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('7', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('5', 'rallies');
INSERT INTO user_interests (user, interests) VALUES ('6', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('2', 'protesters');
INSERT INTO user_interests (user, interests) VALUES ('2', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('10', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political ideologies');
INSERT INTO user_interests (user, interests) VALUES ('9', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('4', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('8', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('9', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('3', 'policy');
INSERT INTO user_interests (user, interests) VALUES ('8', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political campaigns');
INSERT INTO user_interests (user, interests) VALUES ('9', 'government');
INSERT INTO user_interests (user, interests) VALUES ('4', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('5', 'government');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political movements');
INSERT INTO user_interests (user, interests) VALUES ('4', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('10', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('5', 'demonstrations');
INSERT INTO user_interests (user, interests) VALUES ('3', 'parties');
INSERT INTO user_interests (user, interests) VALUES ('1', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('5', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('5', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('7', 'legislation');
INSERT INTO user_interests (user, interests) VALUES ('2', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('9', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('4', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('10', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('5', 'policy');
INSERT INTO user_interests (user, interests) VALUES ('8', 'protests');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political theory');
INSERT INTO user_interests (user, interests) VALUES ('5', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('6', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('3', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political history');
INSERT INTO user_interests (user, interests) VALUES ('8', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('5', 'lobbying');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('4', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('7', 'grassroots movements');
INSERT INTO user_interests (user, interests) VALUES ('9', 'candidates');
INSERT INTO user_interests (user, interests) VALUES ('10', 'campaigns');
INSERT INTO user_interests (user, interests) VALUES ('7', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('8', 'elections');
INSERT INTO user_interests (user, interests) VALUES ('3', 'political science');
INSERT INTO user_interests (user, interests) VALUES ('1', 'political activism');
INSERT INTO user_interests (user, interests) VALUES ('2', 'political parties');
INSERT INTO user_interests (user, interests) VALUES ('10', 'demonstrations');
INSERT INTO user_interests (user, interests) VALUES ('7', 'civil rights');
INSERT INTO user_interests (user, interests) VALUES ('1', 'activism');
INSERT INTO user_interests (user, interests) VALUES ('3', 'government');
INSERT INTO user_interests (user, interests) VALUES ('7', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('4', 'social justice');
INSERT INTO user_interests (user, interests) VALUES ('9', 'public policy');
INSERT INTO user_interests (user, interests) VALUES ('6', 'voters');
INSERT INTO user_interests (user, interests) VALUES ('2', 'politics');
INSERT INTO user_interests (user, interests) VALUES ('10', 'political campaigns');

INSERT INTO news_likes (user, news_article) VALUES ('6', '10');
INSERT INTO news_likes (user, news_article) VALUES ('3', '5');
INSERT INTO news_likes (user, news_article) VALUES ('7', '30');
INSERT INTO news_likes (user, news_article) VALUES ('9', '9');
INSERT INTO news_likes (user, news_article) VALUES ('9', '18');
INSERT INTO news_likes (user, news_article) VALUES ('1', '29');
INSERT INTO news_likes (user, news_article) VALUES ('9', '24');
INSERT INTO news_likes (user, news_article) VALUES ('7', '15');
INSERT INTO news_likes (user, news_article) VALUES ('9', '24');
INSERT INTO news_likes (user, news_article) VALUES ('7', '26');
INSERT INTO news_likes (user, news_article) VALUES ('3', '25');
INSERT INTO news_likes (user, news_article) VALUES ('10', '12');
INSERT INTO news_likes (user, news_article) VALUES ('4', '21');
INSERT INTO news_likes (user, news_article) VALUES ('9', '3');
INSERT INTO news_likes (user, news_article) VALUES ('4', '1');
INSERT INTO news_likes (user, news_article) VALUES ('1', '11');
INSERT INTO news_likes (user, news_article) VALUES ('10', '27');
INSERT INTO news_likes (user, news_article) VALUES ('10', '24');
INSERT INTO news_likes (user, news_article) VALUES ('6', '20');
INSERT INTO news_likes (user, news_article) VALUES ('7', '22');
