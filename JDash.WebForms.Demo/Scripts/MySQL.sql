

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT 

EXISTS `JDashWebFormsDemo`
  CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `JDashWebFormsDemo`;


DROP TABLE IF EXISTS `JDashWebFormsDemo`.`DashletModule`;
CREATE TABLE 

`JDashWebFormsDemo`.`DashletModule` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(255) CHARACTER SET utf8 

COLLATE utf8_general_ci NOT NULL,
  `title` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `config` 

LONGTEXT NOT NULL,
  `paneConfig` LONGTEXT NOT NULL,
  `dashletConfig` LONGTEXT NOT NULL,
  `style` LONGTEXT NULL,
  `cls` 

LONGTEXT NULL,
  `attr` LONGTEXT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  

`createdBy` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modifiedBy` VARCHAR(150) CHARACTER SET 

utf8 COLLATE utf8_general_ci NULL,
  `sharedBy` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created` 

DATETIME NOT NULL,
  `modified` DATETIME NULL,
  `shared` DATETIME NULL,
  `groupName` VARCHAR(150) CHARACTER SET utf8 

COLLATE utf8_general_ci NULL,
  `userData` LONGTEXT NULL,
  `viewOrder` INT(10) NULL,
  `groupOrder` INT(10) NULL,
  

`UserProperty1` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `UserProperty2` VARCHAR(250) CHARACTER SET 

utf8 COLLATE utf8_general_ci NULL,
  `UserProperty3` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY 

KEY (`id`),
  INDEX `IX_DashletModule` (`UserProperty1`),
  INDEX `IX_DashletModule_1` (`UserProperty2`),
  INDEX 

`IX_DashletModule_2` (`UserProperty3`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `JDashWebFormsDemo`.`EntityAuth`;
CREATE TABLE 

`JDashWebFormsDemo`.`EntityAuth` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `entityType` VARCHAR(50) CHARACTER SET utf8 

COLLATE utf8_general_ci NOT NULL,
  `entityId` INT(10) NOT NULL,
  `roleOrUser` VARCHAR(50) CHARACTER SET utf8 COLLATE 

utf8_general_ci NOT NULL,
  `permission` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `authType` 

VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `IX_EntityAuth` 

(`entityType`, `entityId`, `roleOrUser`, `authType`, `permission`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS 

`JDashWebFormsDemo`.`Tag`;
CREATE TABLE `JDashWebFormsDemo`.`Tag` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `tagName` 

VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS 

`JDashWebFormsDemo`.`TagRelation`;
CREATE TABLE `JDashWebFormsDemo`.`TagRelation` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  

`tagId` INT(10) NOT NULL,
  `controlId` INT(10) NOT NULL,
  `controller` VARCHAR(15) CHARACTER SET utf8 COLLATE 

utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_TagRelation_Dashboard` FOREIGN KEY 

`FK_TagRelation_Dashboard` (`controlId`)
    REFERENCES `JDashWebFormsDemo`.`Dashboard` (`id`)
    ON DELETE NO ACTION
    ON 

UPDATE NO ACTION,
  CONSTRAINT `FK_TagRelation_DashletModule` FOREIGN KEY `FK_TagRelation_DashletModule` (`controlId`)
    

REFERENCES `JDashWebFormsDemo`.`DashletModule` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 

`FK_TagRelation_Dashlets` FOREIGN KEY `FK_TagRelation_Dashlets` (`controlId`)
    REFERENCES `JDashWebFormsDemo`.`Dashlet` 

(`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TagRelation_Tags` FOREIGN KEY `FK_TagRelation_Tags` 

(`tagId`)
    REFERENCES `JDashWebFormsDemo`.`Tag` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
ENGINE = INNODB;

DROP 

TABLE IF EXISTS `JDashWebFormsDemo`.`Dashboard`;
CREATE TABLE `JDashWebFormsDemo`.`Dashboard` (
  `id` INT(10) NOT NULL 

AUTO_INCREMENT,
  `title` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `layout` LONGTEXT NOT NULL,
  

`config` LONGTEXT NULL,
  `paneConfig` LONGTEXT NULL,
  `style` LONGTEXT NULL,
  `cls` LONGTEXT NULL,
  `attr` LONGTEXT NULL,
  

`groupName` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 

COLLATE utf8_general_ci NULL,
  `createdBy` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modifiedBy` 

VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sharedBy` VARCHAR(150) CHARACTER SET utf8 COLLATE 

utf8_general_ci NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NULL,
  `shared` DATETIME NULL,
  `userData` 

LONGTEXT NULL,
  `viewOrder` INT(10) NULL,
  `groupOrder` INT(10) NULL,
  `UserProperty1` VARCHAR(250) CHARACTER SET utf8 

COLLATE utf8_general_ci NULL,
  `UserProperty2` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  

`UserProperty3` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`),
  INDEX `IX_Dashboard` 

(`UserProperty1`),
  INDEX `IX_Dashboard_1` (`UserProperty2`),
  INDEX `IX_Dashboard_2` (`UserProperty3`)
)
ENGINE = INNODB;

DROP TABLE IF EXISTS `JDashWebFormsDemo`.`Dashlet`;
CREATE TABLE `JDashWebFormsDemo`.`Dashlet` (
  `id` INT(10) NOT NULL 

AUTO_INCREMENT,
  `dashboardId` INT(10) NOT NULL,
  `dashletModuleId` INT(10) NOT NULL,
  `title` VARCHAR(255) CHARACTER SET 

utf8 COLLATE utf8_general_ci NULL,
  `config` LONGTEXT NULL,
  `paneConfig` LONGTEXT NULL,
  `position` LONGTEXT NOT NULL,
  

`style` LONGTEXT NULL,
  `cls` LONGTEXT NULL,
  `attr` LONGTEXT NULL,
  `groupName` VARCHAR(150) CHARACTER SET utf8 COLLATE 

utf8_general_ci NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `createdBy` VARCHAR

(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modifiedBy` VARCHAR(150) CHARACTER SET utf8 COLLATE 

utf8_general_ci NULL,
  `sharedBy` VARCHAR(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created` DATETIME NOT 

NULL,
  `modified` DATETIME NULL,
  `shared` DATETIME NULL,
  `userData` LONGTEXT NULL,
  `UserProperty1` VARCHAR(250) 

CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `UserProperty2` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci 

NULL,
  `UserProperty3` VARCHAR(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`),
  INDEX 

`IX_Dashlet` (`UserProperty1`),
  INDEX `IX_Dashlet_1` (`UserProperty2`),
  INDEX `IX_Dashlet_2` (`UserProperty3`),
  

CONSTRAINT `FK_Dashlets_Dashboard` FOREIGN KEY `FK_Dashlets_Dashboard` (`dashboardId`)
    REFERENCES 

`JDashWebFormsDemo`.`Dashboard` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Dashlets_DashletModules` 

FOREIGN KEY `FK_Dashlets_DashletModules` (`dashletModuleId`)
    REFERENCES `JDashWebFormsDemo`.`DashletModule` (`id`)
    

ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = INNODB;



SET FOREIGN_KEY_CHECKS = 1;




SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

INSERT INTO `JDashWebFormsDemo`.`DashletModule`(`id`, `path`, `title`, `config`, `paneConfig`, `dashletConfig`, `style`, `cls`, `attr`, `description`, `createdBy`, `modifiedBy`, `sharedBy`, `created`, `modified`, `shared`, `groupName`, `userData`, `viewOrder`, `groupOrder`, `UserProperty1`, `UserProperty2`, `UserProperty3`)
VALUES (207, '[WfDefault]', 'HTML', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/html/view.ascx\",\"ec\":\"~/jdash/dashlets/html/edit.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":\"400px\",\"height\":\"-\"},\"useWindow\":true}}', '{\"cssClass\":null,\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Allows to use html mark-up inside a dashlet.', 'berkay', NULL, NULL, '2013-09-27 06:05:00', NULL, NULL, 'Dashlet Library', NULL, NULL, NULL, NULL, NULL, NULL),
  (208, '[WfDefault]', 'RSS Reader', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{\"width\":\"-\",\"height\":\"-\",\"cssClass\":\"-\"}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Retreives rss feeds and displays inside dashlet.', 'berkay', NULL, NULL, '2013-09-29 18:05:00', NULL, NULL, 'Dashlet Library', NULL, NULL, NULL, NULL, NULL, NULL),
  (209, 'jdash/dashlets/highchart/hcModule', 'Highchart Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/Highchart/view.ascx\",\"ec\":\"~/jdash/dashlets/Highchart/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":\"nopad\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Displays a Highchart chart.', 'berkay', NULL, NULL, '2013-09-30 12:05:00', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (211, '[WfDefault]', 'Publisher', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/Publisher/View.ascx\",\"ec\":\"~/jdash/dashlets/Publisher/Edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":\"\"},\"useWindow\":false}}', '{\"builtInCommands\":[\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, '', 'berkay', NULL, NULL, '2013-10-01 15:05:00', NULL, NULL, 'Samples', NULL, NULL, NULL, NULL, NULL, NULL),
  (212, '[WfDefault]', 'Consumer', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/Consumer/View.ascx\",\"ec\":\"~/jdash/dashlets/Consumer/Edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":\"\"},\"useWindow\":false}}', '{\"builtInCommands\":[\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, '', 'berkay', NULL, NULL, '2013-10-01 15:05:00', NULL, NULL, 'Samples', NULL, NULL, NULL, NULL, NULL, NULL),
  (213, 'jdash/dashlets/jqplot/jqPlotModule', 'JqPlot Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/JqPlot/view.ascx\",\"ec\":\"~/jdash/dashlets/JqPlot/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":null,\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Displays a JqPlot chart', 'berkay', NULL, NULL, '2013-10-01 06:05:00', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (219, '[WfDefault]', 'Google Code', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"themeStyleId\":\"b\",\"disableTheming\":true,\"customCommands\":[]}', '{\"RssUrl\":\"http://feeds.feedburner.com/GDBcode?format=xml\",\"Interval\":15,\"ShowBody\":false}', NULL, NULL, NULL, 'A pre configured Rss Reader for Google Code Blog.', 'berkay', NULL, NULL, '2013-10-01 09:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (220, '[WfDefault]', 'Event Capturer', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/EventCapture/view.ascx\",\"ec\":null,\"autoEdit\":false,\"notifications\":{\"commands\":[\"ClearCapturedEvents\"]}}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[{\"name\":\"ClearCapturedEvents\",\"label\":\"Clear Captured Events\",\"type\":\"custom\",\"confirm\":true,\"confirmMessage\":\"Clear all events captured ?\",\"ui\":{\"iconClass\":\"d-icon-trash\",\"title\":\"Clear Captured Events\"}}],\"cssClass\":\"nopad\"}', '{}', NULL, NULL, NULL, 'Listens for events, captures and displays.', '', NULL, NULL, '2013-03-27 21:38:14', NULL, NULL, 'Samples', NULL, NULL, NULL, NULL, NULL, NULL),
  (221, 'JDash/Dashlets/GoogleMaps/GoogleMap', 'Google Map Template', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/GoogleMaps/view.ascx\",\"ec\":\"~/jdash/dashlets/GoogleMaps/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":\"nopad\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, '', '', NULL, NULL, '2013-03-27 18:04:02', NULL, NULL, 'Samples', NULL, NULL, NULL, NULL, NULL, NULL),
  (222, '[WfDefault]', 'Pop Client', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/PopClient/view.ascx\",\"ec\":\"~/jdash/dashlets/PopClient/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"refresh\"]}},\"editor\":{\"paneConfig\":{\"width\":\"500px\",\"height\":\"450px\",\"cssClass\":null},\"useWindow\":true}}', '{\"cssClass\":\"popClient\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Connects Smtp servers to get e-mails.', '', NULL, NULL, '2013-03-27 14:17:36', NULL, NULL, 'Dashlet Library', NULL, NULL, NULL, NULL, NULL, NULL),
  (223, '[WfDefault]', 'Ms Chart Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/MsChart/view.ascx\",\"ec\":\"~/jdash/dashlets/MsChart/edit.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[\"refresh\"]}},\"editor\":{\"paneConfig\":{\"width\":\"550px\",\"height\":\"375px\",\"cssClass\":null},\"useWindow\":true}}', '{\"cssClass\":\"msChart\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Sample MsCharts', '', NULL, NULL, '2013-03-28 01:27:27', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (224, '[WfDefault]', 'Rich Text Editor', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/RichText/View.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[]},\"ec\":\"~/Jdash/dashlets/RichText/Edit.ascx\"},\"editor\":{\"paneConfig\":{\"cssClass\":\"rtEditor\",\"width\":\"500px\",\"height\":\"-\"},\"useWindow\":true,\"path\":\"JDash/Dashlets/RichText/RichTextEditor\"}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[],\"cssClass\":null}', '{}', NULL, NULL, NULL, '', '', NULL, NULL, '2013-03-29 01:49:18', NULL, NULL, 'Dashlet Library', NULL, NULL, NULL, NULL, NULL, NULL),
  (229, 'JDash/Dashlets/D3/D3Module', 'D3 Sample', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/D3/View.ascx\",\"ec\":\"~/Jdash/dashlets/D3/Edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[],\"cssClass\":\"D3Dashlet\"}', '{}', NULL, NULL, NULL, '', '', NULL, NULL, '2013-03-31 18:01:10', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (232, 'JDash/Dashlets/PolyLines/GoogleMapVisualizer', 'Geographic Polylines Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/PolyLines/view.ascx\",\"ec\":\"~/jdash/dashlets/PolyLines/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":\"googleMapVis\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, '', '', NULL, NULL, '2013-04-02 05:08:09', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (233, 'JDash/Dashlets/HeatMap/GoogleMapVisualizer', 'Geographic Heat Map Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/HeatMap/view.ascx\",\"ec\":\"~/jdash/dashlets/HeatMap/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":\"googleMapVis\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, '', '', NULL, NULL, '2013-04-03 11:41:45', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (236, '[WfDefault]', 'Reddit Programming', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"themeStyleId\":\"b\",\"disableTheming\":true,\"customCommands\":[]}', '{\"RssUrl\":\"http://www.reddit.com/r/programming/.rss\",\"Interval\":15,\"ShowBody\":false}', NULL, NULL, NULL, 'A pre configured Rss Reader for programming sub Reddit.', 'berkay', NULL, NULL, '2013-10-01 06:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (237, '[WfDefault]', 'Microsoft Offical Blog', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"themeStyleId\":\"b\",\"disableTheming\":true,\"customCommands\":[]}', '{\"RssUrl\":\"http://blogs.technet.com/b/microsoft_blog/rss.aspx\",\"Interval\":15,\"ShowBody\":false}', NULL, NULL, NULL, 'A pre configured Rss Reader for Microsoft Blog.', 'berkay', NULL, NULL, '2013-10-01 06:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (238, '[WfDefault]', 'Software Engineering Radio', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"themeStyleId\":\"b\",\"disableTheming\":true,\"customCommands\":[]}', '{\"RssUrl\":\"http://www.se-radio.net/feed/\",\"Interval\":15,\"ShowBody\":false}', NULL, NULL, NULL, 'The Podcast for Professional Software Developers.', 'berkay', NULL, NULL, '2013-10-01 06:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (239, '[WfDefault]', 'Net Tuts+', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"themeStyleId\":\"b\",\"disableTheming\":true,\"customCommands\":[]}', '{\"RssUrl\":\"http://feeds.feedburner.com/nettuts\",\"Interval\":15,\"ShowBody\":false}', NULL, NULL, NULL, 'Offical Net Tuts+ feeds.', 'berkay', NULL, NULL, '2013-10-01 06:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (240, 'jdash/dashlets/FusionCharts/FusionChart', 'Fusion Charts Sample', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/FusionCharts/view.ascx\",\"ec\":\"~/jdash/dashlets/FusionCharts/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"cssClass\":\"nopad\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{}', NULL, NULL, NULL, 'Displays a Fusion Chart.', 'berkay', NULL, NULL, '2013-09-29 18:05:00', NULL, NULL, 'Sample Visualizations', NULL, NULL, NULL, NULL, NULL, NULL),
  (241, '[WfDefault]', 'CNN Top News', '{\"wfConfig\":{\"uc\":\"~/jdash/dashlets/RssReader/view.ascx\",\"ec\":\"~/jdash/dashlets/RssReader/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"maximize\",\"restore\"]}},\"editor\":{\"useWindow\":false,\"paneConfig\":{}}}', '{\"cssClass\":\"rssReader\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"RssUrl\":\"http://rss.cnn.com/rss/edition.rss\",\"Interval\":5,\"ShowBody\":true}', NULL, NULL, NULL, 'A pre configured Rss Reader for CNN Top News', 'berkay', NULL, NULL, '2013-10-01 12:05:00', NULL, NULL, 'Rss Feeds', NULL, NULL, NULL, NULL, NULL, NULL),
  (246, '[WfDefault]', 'Dashboard List', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/DashboardList/view.ascx\",\"ec\":\"~/Jdash/dashlets/DashboardList/edit.ascx\",\"autoEdit\":false,\"notifications\":{\"commands\":[\"refresh\"]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":null,\"height\":null},\"useWindow\":false}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{}', NULL, NULL, NULL, 'Listens for events, captures and displays.', '', NULL, NULL, '2013-03-27 15:38:14', NULL, NULL, 'Dashlet Library', NULL, NULL, NULL, NULL, NULL, NULL),
  (250, '[WfDefault]', 'Table View', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/DataAnalysis/tableview.ascx\",\"ec\":\"~/Jdash/dashlets/DataAnalysis/tableviewEditor.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[\"refresh\"]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":\"500px\",\"height\":\"600px\"},\"useWindow\":true}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{}', NULL, NULL, NULL, 'Displays analysis results as a regular table', '', NULL, NULL, '2013-03-27 07:38:14', NULL, NULL, 'Sample Data Analysis', NULL, NULL, NULL, NULL, NULL, NULL),
  (251, 'jdash/dashlets/dataanalysis/chartdashlet', 'Chart View', '{\"wfConfig\":{\"uc\":\"~/Jdash/dashlets/DataAnalysis/chartview.ascx\",\"ec\":\"~/Jdash/dashlets/DataAnalysis/chartviewEditor.ascx\",\"autoEdit\":true,\"notifications\":{\"commands\":[\"refresh\"]}},\"editor\":{\"paneConfig\":{\"cssClass\":null,\"width\":\"500px\",\"height\":\"550px\"},\"useWindow\":true}}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{}', NULL, NULL, NULL, 'Visualize your data by charts', '', NULL, NULL, '2013-03-26 21:38:14', NULL, NULL, 'Sample Data Analysis', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO `JDashWebFormsDemo`.`EntityAuth`(`id`, `entityType`, `entityId`, `roleOrUser`, `permission`, `authType`)
VALUES (43, 'dashboard', 399, 'berkay', 'view', 'userName');

INSERT INTO `JDashWebFormsDemo`.`Tag`(`id`, `tagName`)
VALUES (2, 'TestTag'),
  (3, 'TestTag2');

INSERT INTO `JDashWebFormsDemo`.`TagRelation`(`id`, `tagId`, `controlId`, `controller`)
VALUES (6, 2, 4341, 'dashlet'),
  (7, 3, 106, 'dashletModule');

INSERT INTO `JDashWebFormsDemo`.`Dashboard`(`id`, `title`, `layout`, `config`, `paneConfig`, `style`, `cls`, `attr`, `groupName`, `description`, `createdBy`, `modifiedBy`, `sharedBy`, `created`, `modified`, `shared`, `userData`, `viewOrder`, `groupOrder`, `UserProperty1`, `UserProperty2`, `UserProperty3`)
VALUES (467, 'Home Dashboard', '{\"type\":\"grid\",\"sections\":{\"section1\":{\"zones\":{\"zone1\":{}}},\"section2\":{\"zones\":{\"zone1\":{},\"zone2\":{},\"zone3\":{},\"zone4\":{}}},\"section3\":{\"zones\":{\"zone1\":{}}}},\"addFirst\":true}', 'null', 'null', NULL, NULL, NULL, 'Built-in Dashboards', '', '', NULL, NULL, '2013-04-05 12:13:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (473, 'First Dashboard', '{\"type\":\"grid\",\"sections\":{\"section1\":{\"zones\":{\"zone1\":{},\"zone2\":{\"flex\":2}}}},\"addFirst\":true}', 'null', 'null', NULL, NULL, NULL, 'Your Dashboards', '', '', NULL, NULL, '2013-04-06 19:13:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (475, 'Online Tutorial', '{\"type\":\"grid\",\"sections\":{\"section1\":{\"zones\":{\"zone1\":{}}}},\"addFirst\":true}', 'null', 'null', NULL, NULL, NULL, 'Built-in Dashboards', '', '', NULL, NULL, '2013-04-14 10:41:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
  (483, 'Data Analysis Demo', '{\"type\":\"grid\",\"sections\":{\"section1\":{\"zones\":{\"zone1\":{}}},\"section2\":{\"zones\":{\"zone1\":{},\"zone2\":{\"flex\":2}}},\"section3\":{\"zones\":{\"zone1\":{}}}},\"addFirst\":true}', 'null', 'null', NULL, NULL, NULL, 'Built-in Dashboards', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:52:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO `JDashWebFormsDemo`.`Dashlet`(`id`, `dashboardId`, `dashletModuleId`, `title`, `config`, `paneConfig`, `position`, `style`, `cls`, `attr`, `groupName`, `description`, `createdBy`, `modifiedBy`, `sharedBy`, `created`, `modified`, `shared`, `userData`, `UserProperty1`, `UserProperty2`, `UserProperty3`)
VALUES (7260, 467, 209, 'Highchart Sample', '{\"preset\":\"Budget Balance\",\"theme\":\"default\"}', '{\"cssClass\":\"nopad homeRow2\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"section\":\"section2\",\"zone\":\"zone3\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-05 16:18:19', NULL, NULL, NULL, NULL, NULL, NULL),
  (7291, 467, 223, 'Ms Chart Sample', '{\"settings\":\"<?xml version=\\\"1.0\\\" encoding=\\\"utf-16\\\"?><MsChartSettings xmlns:i=\\\"http://www.w3.org/2001/XMLSchema-instance\\\" xmlns=\\\"http://schemas.datacontract.org/2004/07/JDash.WebForms.Demo.Jdash.Dashlets.MsChart\\\"><_x003C_AlphaLevel_x003E_k__BackingField>128</_x003C_AlphaLevel_x003E_k__BackingField><_x003C_AreaBackColor_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_AreaGradient_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_AreaSecondaryBackColor_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_BackColor_x003E_k__BackingField>White</_x003C_BackColor_x003E_k__BackingField><_x003C_BorderSkin_x003E_k__BackingField>None</_x003C_BorderSkin_x003E_k__BackingField><_x003C_ChartKey_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_ChartType_x003E_k__BackingField>33</_x003C_ChartType_x003E_k__BackingField><_x003C_CollectPieOther_x003E_k__BackingField>false</_x003C_CollectPieOther_x003E_k__BackingField><_x003C_CollectedPieTreshold_x003E_k__BackingField>0</_x003C_CollectedPieTreshold_x003E_k__BackingField><_x003C_Description_x003E_k__BackingField></_x003C_Description_x003E_k__BackingField><_x003C_Enable3D_x003E_k__BackingField>true</_x003C_Enable3D_x003E_k__BackingField><_x003C_Gradient_x003E_k__BackingField>None</_x003C_Gradient_x003E_k__BackingField><_x003C_HasBorderColor_x003E_k__BackingField>true</_x003C_HasBorderColor_x003E_k__BackingField><_x003C_Height_x003E_k__BackingField>500</_x003C_Height_x003E_k__BackingField><_x003C_IsClustured_x003E_k__BackingField>true</_x003C_IsClustured_x003E_k__BackingField><_x003C_IsShownValues_x003E_k__BackingField>true</_x003C_IsShownValues_x003E_k__BackingField><_x003C_LegendAlignment_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_LegendDocking_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_LegendStyle_x003E_k__BackingField i:nil=\\\"true\\\" /><_x003C_LegendsEnabled_x003E_k__BackingField>false</_x003C_LegendsEnabled_x003E_k__BackingField><_x003C_MarkerSize_x003E_k__BackingField>0</_x003C_MarkerSize_x003E_k__BackingField><_x003C_MarkerStyle_x003E_k__BackingField>None</_x003C_MarkerStyle_x003E_k__BackingField><_x003C_Palette_x003E_k__BackingField>BrightPastel</_x003C_Palette_x003E_k__BackingField><_x003C_PieDrawingStyle_x003E_k__BackingField>Default</_x003C_PieDrawingStyle_x003E_k__BackingField><_x003C_PieLabelStyle_x003E_k__BackingField>Disabled</_x003C_PieLabelStyle_x003E_k__BackingField><_x003C_SecondaryBackColor_x003E_k__BackingField>White</_x003C_SecondaryBackColor_x003E_k__BackingField><_x003C_SeriesCount_x003E_k__BackingField>0</_x003C_SeriesCount_x003E_k__BackingField><_x003C_ShowLabels_x003E_k__BackingField>true</_x003C_ShowLabels_x003E_k__BackingField><_x003C_ShowMarkersLine_x003E_k__BackingField>false</_x003C_ShowMarkersLine_x003E_k__BackingField><_x003C_TitleAlignment_x003E_k__BackingField>TopCenter</_x003C_TitleAlignment_x003E_k__BackingField><_x003C_Title_x003E_k__BackingField></_x003C_Title_x003E_k__BackingField><_x003C_Width_x003E_k__BackingField>360</_x003C_Width_x003E_k__BackingField></MsChartSettings>\"}', '{\"cssClass\":\"msChart homeRow2\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"section\":\"section2\",\"zone\":\"zone2\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-05 18:33:16', NULL, NULL, NULL, NULL, NULL, NULL),
  (7417, 467, 213, 'JqPlot Sample', '{\"preset\":\"New Year Expectations\"}', '{\"cssClass\":\"homeRow3\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"section\":\"section3\",\"zone\":\"zone1\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-06 15:31:42', NULL, NULL, NULL, NULL, NULL, NULL),
  (7567, 467, 240, 'Fusion Chart Sample', '{\"preset\":{\"title\":\"Weekly Sales Summary\",\"chartConfig\":{\"config\":{\"type\":\"Column3D\",\"width\":\"100%\",\"height\":\"100%\",\"debugMode\":false},\"data\":{\"chart\":{\"caption\":\"Weekly Sales Summary\",\"xAxisName\":\"Week\",\"yAxisName\":\"Sales\",\"numberPrefix\":\"$\"},\"data\":[{\"label\":\"Week 1\",\"value\":\"14400\"},{\"label\":\"Week 2\",\"value\":\"19600\"},{\"label\":\"Week 3\",\"value\":\"24000\"},{\"label\":\"Week 4\",\"value\":\"15700\"}]}}}}', '{\"cssClass\":\"nopad homeRow2\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"section\":\"section2\",\"zone\":\"zone1\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-08 19:17:39', NULL, NULL, NULL, NULL, NULL, NULL),
  (7568, 473, 207, 'HTML', '{\"html\":\"<h1>\\nHi\\n</h1>\\n<p>\\nThis is a dashboard created for you. Things to try follows:\\n</p>\\n<ul>\\n                            <li>Use <i class=\\\"icon-plus-sign\\\"></i>Add Dashlet link to add some dashlets. We demonstrated image/javascript based charts from different vendors in Sample Visualizations tab.</li>\\n<li>Drag-drop dashlets to re-organize them.</li>\\n                            <li>Resize your browser to see responsive design capabilities.</li>\\n   <li>Use <i class=\\\"icon-th\\\"></i>Create link on toolbar to create an other dashboard for you.</li>\\n</ul>\\n\\n<h3>Demo is open source!</h3>\\n<p>\\n <a href=\\\"http://jdash.net/download\\\" target=\\\"_blank\\\">Click</a> to download source code of demo and use it as a start-up for your dashboards.\\n</p>\"}', '{\"cssClass\":\"demo-content\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":2}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-08 20:16:53', NULL, NULL, NULL, NULL, NULL, NULL),
  (7597, 475, 207, 'Step 2 - Configure SQL Server Providers', '{\"html\":\"<p>\\nBuilt-in provider <i>SQLDashboardProvider</i> uses Microsoft SQL Server to retrieve and persist metadata. In this tutorial we will use <i>SQLDashboardProvider</i>.\\n</p>\\n<ol>\\n<li>Using project references window (Inside solution explorer window, right click on References and click Add Reference menu item) add reference to <i>JDash.SqlProvider.dll</i>. Assembly can be found inside installation directory (by default C:\\\\Program Files\\\\Kalitte\\\\JDash\\\\Bin directory).</li>\\n<li>Rebuild your project. If this step fails you may not be able to create metadata at design time.</li>\\n<li>Using SQL Server Management Studio create new database.</li>\\n<li>Return to Visual Studio and add a connection string to web.config for the database you setup on previous step. Ensure connection string has the necessary authentication information for connecting to the database.</li>\\n<li>Open DisplayDashboard.aspx in design view, select <i>ResourceManager</i> control and using smart tag of the control, click JDash Settings menu item.</li>\\n<li>Select the connection string and click Create Metadata button. This will create the necessary tables on your database. Alternatively you can use Get Script button to get the SQL scripts and manually execute the scripts.</li>\\n</ol>\\n<p>Below is a sample screen shot of set settings dialog.</p>\\n<img src=\\\"../../Resource/img/Tutorial/tutorial-img2.png\\\" />\\n\"}', '{\"cssClass\":\"demo-content\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":1}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 10:41:26', NULL, NULL, NULL, NULL, NULL, NULL),
  (7600, 467, 222, 'Pop Client', '{\"username\":\"\",\"password\":\"\",\"server\":\"\",\"port\":110,\"ssl\":false}', '{\"cssClass\":\"popClient homeRow2\",\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[]}', '{\"section\":\"section2\",\"zone\":\"zone4\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 10:57:37', NULL, NULL, NULL, NULL, NULL, NULL),
  (7607, 475, 207, 'Step 1 - Add JDash.Net Controls', '{\"html\":\"<ol>\\n<li>Open Microsoft Visual Studio.Net or your preferred IDE.</li>\\n<li>Create a new Asp.Net Web Application project and add a new page i.e. DisplayDashboard.aspx.</li>\\n<li>Using Toolbox (if not visible use Ctrl-Alt-X key combination to open it) drop <i>ScriptManager</i> (Inside Ajax Extensions tab), then <i>ResourceManager</i> control (Inside Jdash.Net tab) on the page. Settings dialog will be displayed automatically for the first time. Close settings dialog.</li>\\n<li>Finally, drop <i>DashboardView</i> control on to page, after <i>ResourceManager</i> control. Please note control order should be 1 <i>ScriptManager</i>, 2 <i>ResourceManager</i> and then other controls like <i>DashboardView</i>.</li>\\n</ol>\\n<p>Below is a sample screenshot of the page.</p>\\n<img src=\\\"../../Resource/img/Tutorial/tutorial-img1.png\\\" />\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[],\"themeStyleId\":\"a\",\"disableTheming\":false}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":0}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 15:13:33', NULL, NULL, NULL, NULL, NULL, NULL),
  (7609, 475, 207, 'Step 3 - Create Your First Dashlet', '{\"html\":\"<p>In this step you will be creating your first dashlet with a dashlet editor.</p>\\n<ol>\\n<li>Using solution explorer window, select the project and right click. Create a directory named JDash and create another directory Dashlets inside JDash directory. You may choose using other names for directories although this is the recommended setup.</li>\\n<li>Select Dashlets directory. Right click, using Add New Item dialog, add two Asp.Net user controls named HtmlDashlet.ascx and HtmlDashletEditor.ascx inside Dashlets directory.</li>\\n<li>Implement these controls as you like. In this tutorial we will be implementing an Html Dashlet.</li>\\n<li>Open HtmlDashlet.ascx and drop an Asp.Net Literal control.\\n<p><code style=\\\"display:block;color:#424242\\\">&lt;asp:Literal runat=&quot;server&quot; ID=&quot;htmlLit&quot;&gt;&lt;/asp:Literal&gt;</code></p>\\n</li>\\n\\n<li>Implement your dashlet. Below code block shows a sample. Basically, it tries to get the html configuration value set by user and renders it.\\n<p><code style=\\\"display:block;color:#424242\\\">using System;<br/>\\nusing System.Collections.Generic;<br/>\\nusing System.Linq;<br/>\\nusing System.Web;<br/>\\nusing System.Web.UI;<br/>\\nusing System.Web.UI.WebControls;<br/>\\nusing JDash.WebForms;<br/>\\n<br/>\\nnamespace HelloWorld.JDash.Dashlets<br/>\\n{<br/>\\n   &nbsp;&nbsp;&nbsp; public partial class HtmlDashlet : System.Web.UI.UserControl<br/>\\n    &nbsp;&nbsp;&nbsp; {<br/>\\n        &nbsp;&nbsp;&nbsp; &nbsp; private DashletContext context;<br/>\\n<br/>\\n        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;[JEventHandler(JEvent.InitContext)]<br/>\\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;public void InitContext(object sender, JEventArgs args)<br/>\\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br/>\\n            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;this.context = args.Event.Parameters.Get&lt;DashletContext&gt;(&quot;context&quot;);<br/>\\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br/>\\n<br/>\\n       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; public override void DataBind()<br/>\\n        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br/>\\n         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   var htmlString = context.Model.config.Get&lt;string&gt;(&quot;html&quot;, &quot;&quot;);<br/>\\n         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   htmlLit.Text = htmlString;<br/>\\n           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.RenderDashlet();<br/>\\n           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base.DataBind();<br/>\\n       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br/>\\n    &nbsp;&nbsp;&nbsp;}<br/>\\n}<br/>\\n</code></p>\\n</li>\\n<li>Open HtmlDashletEditor.ascx. Drop a <i>DashletTitleEditor</i> and <i>DashletStylesList</i> control using Toolbox, JDash tab. Finally add a Textbox. Content of HtmlDashletEditor.ascx should be like this.</li>\\n<p><code style=\\\"display:block;color:#424242\\\">&lt;jdash:DashletTitleEditor ID=&quot;DashletTitleEditor1&quot; runat=&quot;server&quot; /&gt;<br />\\n&lt;jdash:DashletStylesList ID=&quot;DashletStylesList1&quot; runat=&quot;server&quot; /&gt;\\n<br/>&lt;asp:TextBox ID=&quot;htmlInput&quot; runat=&quot;server&quot; Rows=&quot;5&quot; TextMode=&quot;MultiLine&quot;&gt;&lt;/asp:TextBox&gt;\\n</code></p>\\n<li>Implement your dashlet editor.</li>\\n<p><code style=\\\"display:block;color:#424242\\\">\\nusing System;<br />\\nusing System.Collections.Generic;<br />\\nusing System.Linq;<br />\\nusing System.Web;<br />\\nusing System.Web.UI;<br />\\nusing System.Web.UI.WebControls;<br />\\nusing JDash.WebForms;<br />\\n<br />\\nnamespace HelloWorld.JDash.Dashlets<br />\\n{<br />\\n  &nbsp;&nbsp;&nbsp;  public partial class HtmlDashletEditor : System.Web.UI.UserControl<br />\\n&nbsp;&nbsp;&nbsp;    {<br />\\n&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;     DashletContext context = null;<br />\\n\\t\\t<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public override void DataBind()<br />\\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    {<br />\\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      htmlInput.Text = context.Model.config.Get&lt;string&gt;(&quot;html&quot;, &quot;&quot;);<br />\\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      base.DataBind();<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     }<br />\\n\\t\\t<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     [JEventHandler(JEvent.InitContext)]<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public void InitContext(object sender, JEventArgs args)<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     {<br />\\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       this.context = args.Event.Parameters.Get&lt;DashletContext&gt;(&quot;context&quot;);<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     }<br />\\n\\t\\t<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     [JEventHandler(JEvent.ValidateDashletEditor)]<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     public void ValidateDashletEditor(object sender, JEventArgs args)<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     {<br />\\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        context.Model.config[&quot;html&quot;] = htmlInput.Text;<br />\\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       context.SaveModel();<br />\\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      context.DashletControl.DataBind();<br />\\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    }<br />\\n &nbsp;&nbsp;&nbsp;   }<br />\\n}\\n</code></p>\\n<li>Now it is time to register your first dashlet. Select ResourceManager control and use smart tag of the control to open Management Portal. This is the application where you will define your dashlets.</li>\\n<li>Click Dashlet Modules and create a new one. Note we just set a title, user control path for dashlet and editor control path.</li>\\n</ol>\\n<img src=\\\"../../Resource/img/Tutorial/tutorial-img3.png\\\" />\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":2}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 15:50:13', NULL, NULL, NULL, NULL, NULL, NULL),
  (7611, 475, 207, 'Step 4 - Create a New Dashboard', '{\"html\":\"<p>In this step you will create a sample dashboard management page.<p>\\n\\n<ol>\\n<li>Using project references window add reference to <i>JDash.dll</i> which can be found inside installation directory (by default C:\\\\Program Files\\\\Kalitte\\\\JDash\\\\Bin directory).</li>\\n<li>Add a new Asp.Net page to your project (i.e. ManageDashboards.aspx). Using this page you will be creating and viewing dashboards.</li>\\n<li>Drop an Asp.Net Textbox, Button and Repeater control on the page. Below list shows a sample markup. This page basically lists current dashboards and allows user to click to a dashboard to view it. Note we use query string to pass id of clicked dashboard.\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\n\\n&lt;form id=&quot;form1&quot; runat=&quot;server&quot;&gt; <br />\\n&lt;div&gt; <br />\\n&nbsp;&nbsp;&nbsp;  &lt;asp:TextBox ID=&quot;dashTitle&quot; runat=&quot;server&quot;&gt;&lt;/asp:TextBox&gt; <br />\\n&nbsp;&nbsp;&nbsp;  &lt;asp:Button ID=&quot;createBtn&quot; runat=&quot;server&quot; Text=&quot;Create Dashboard&quot; \\n              OnClick=&quot;createBtn_Click&quot; /&gt;&lt;br /&gt; <br />\\n &nbsp;&nbsp;&nbsp; &lt;asp:Label Text=&quot;Dashboards&quot; runat=&quot;server&quot; /&gt;&lt;br /&gt; <br />\\n&nbsp;&nbsp;&nbsp;  &lt;asp:Repeater runat=&quot;server&quot; id=&quot;listRepeater&quot;&gt; <br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      &lt;ItemTemplate&gt; <br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       &lt;asp:HyperLink runat=&quot;server&quot; Target=&quot;_blank&quot;\\n                         Text=&#39;&lt;%# Eval(&quot;title&quot;) %&gt;&#39; \\nNavigateUrl=&#39;&lt;%# string.Format(&quot;/DisplayDashboard.aspx?id={0}&quot;, Eval(&quot;Id&quot;))  %&gt;&#39;&gt;&lt;/asp:HyperLink&gt; \\n           &lt;br /&gt; <br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      &lt;/ItemTemplate&gt; <br />\\n &nbsp;&nbsp;&nbsp;  &lt;/asp:Repeater&gt; <br />\\n&lt;/div&gt; <br />\\n&lt;/form&gt; <br />\\n\\n\\n\\n</code></p>\\n</li>\\n<li>Inside page load handler bind current dashboards to repeater.\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\nusing System;<br />\\nusing System.Collections.Generic;<br />\\nusing System.Linq;<br />\\nusing System.Web;<br />\\nusing System.Web.UI;<br />\\nusing System.Web.UI.WebControls;<br />\\nusing JDash;<br />\\nusing JDash.Models;<br />\\n<br />\\n...<br />\\n<br />\\nprotected void Page_Load(object sender, EventArgs e)<br />\\n{<br />\\n&nbsp;&nbsp;&nbsp;    if (!Page.IsPostBack)<br />\\n&nbsp;&nbsp;&nbsp;    {<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     listRepeater.DataSource = JDashManager.Provider.SearchDashboards().data;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     listRepeater.DataBind();<br />\\n &nbsp;&nbsp;&nbsp;   }<br />\\n}<br />\\n\\n</code></p>\\n\\n\\n</li>\\n<li>Inside click handler of button, create a new dashboard.\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\nprotected void createBtn_Click(object sender, EventArgs e)<br />\\n{<br />\\n&nbsp;&nbsp;&nbsp;   var newDashboard = new DashboardModel()<br />\\n &nbsp;&nbsp;&nbsp;  {<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  title = dashTitle.Text<br />\\n  &nbsp;&nbsp;&nbsp; };<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;JDashManager.Provider.CreateDashboard(newDashboard);<br />\\n  &nbsp;&nbsp;&nbsp; listRepeater.DataSource = JDashManager.Provider.SearchDashboards().data;<br />\\n  &nbsp;&nbsp;&nbsp; listRepeater.DataBind();<br />\\n}\\n\\n\\n</code></p>\\n\\n\\n</li>\\n</ol>\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":3}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 15:54:49', NULL, NULL, NULL, NULL, NULL, NULL),
  (7612, 475, 207, 'Step 5 - Display and Design Dashboard', '{\"html\":\"<p>Final step is to add basic design functionality to DisplayDashboard.aspx.</p>\\n\\n<ol>\\n<li>Open DisplayDashboard.aspx file, add an update panel and repeater. Repeater will be used to list dashlet modules and user will click a dashlet module to add it to dashboard. Please note we have changed <i>UserDesignMode</i> property of <i>DashboardView </i>control.\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\n&lt;form id=&quot;form1&quot; runat=&quot;server&quot;&gt;<br />\\n&nbsp;&nbsp;&nbsp;  &lt;div&gt;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;asp:ScriptManager ID=&quot;ScriptManager1&quot; runat=&quot;server&quot;&gt;&lt;/asp:ScriptManager&gt;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;jdash:ResourceManager ID=&quot;ResourceManager1&quot; runat=&quot;server&quot; /&gt;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;asp:UpdatePanel runat=&quot;server&quot;&gt;<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;ContentTemplate&gt;<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;asp:Repeater runat=&quot;server&quot; id=&quot;modulesList&quot; \\n                     OnItemCommand=&quot;modulesList_ItemCommand&quot;&gt;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        &lt;ItemTemplate&gt;<br />\\n      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     &lt;asp:LinkButton runat=&quot;server&quot; Text=&#39;&lt;%# Eval(&quot;title&quot;) %&gt;&#39; \\n                           CommandArgument=&#39;&lt;%# Eval(&quot;id&quot;) %&gt;&#39;&gt;&lt;/asp:LinkButton&gt;<br />\\n     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;/ItemTemplate&gt;<br />\\n   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &lt;/asp:Repeater&gt;<br />\\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/ContentTemplate&gt;<br />\\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &lt;/asp:UpdatePanel&gt;<br />\\n &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;jdash:DashboardView ID=&quot;myDashboard&quot; UserDesignMode=&quot;full&quot; runat=&quot;server&quot; /&gt;<br />\\n &nbsp;&nbsp;&nbsp; &lt;/div&gt;<br />\\n&lt;/form&gt;<br />\\n\\n\\n\\n</code></p>\\n</li>\\n\\n<li>On page load handler, use query string parameter to get <i>id</i> of dashboard which should be loaded by <i>DashboardView</i> control. We also bind dashlet modules to repeater.\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\n\\n\\n\\nprotected void Page_Load(object sender, EventArgs e)<br />\\n{<br />\\n &nbsp;&nbsp;&nbsp;  if (!Page.IsPostBack &amp;&amp; !string.IsNullOrEmpty(Request.QueryString[&quot;id&quot;]))<br />\\n    &nbsp;&nbsp;&nbsp;  {<br />\\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       myDashboard.DashboardId = Request.QueryString[&quot;id&quot;];<br />\\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       myDashboard.DataBind();<br />\\n     &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;       modulesList.DataSource = JDashManager.Provider.SearchDashletModules().data;<br />\\n      &nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;      modulesList.DataBind();<br />\\n  &nbsp;&nbsp;&nbsp;     }<br />\\n}<br />\\n\\n\\n</code></p>\\n</li>\\n<li>Final step is to create a dashlet.\\n\\n<p><code style=\\\"display:block; color:#424242\\\">\\n\\n\\nprotected void modulesList_ItemCommand(object source, RepeaterCommandEventArgs e)<br />\\n{<br />\\n&nbsp;&nbsp;&nbsp;     var moduleId = e.CommandArgument.ToString();<br />\\n &nbsp;&nbsp;&nbsp;    var module = JDashManager.Provider.GetDashletModule(moduleId);<br />\\n &nbsp;&nbsp;&nbsp;    var newDashlet = new DashletModel(module);<br />\\n&nbsp;&nbsp;&nbsp;     myDashboard.CreateDashlet(newDashlet);<br />\\n}<br />\\n\\n\\n</code></p>\\n</li>\\n</ol>\\n\\n<p>All done and everything is automatically managed by JDash.Net framework. You may create as many as dashlets you want.</p>\\n<img src=\\\"../../Resource/img/Tutorial/tutorial-img4.png\\\" />\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[]}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":4}', NULL, NULL, NULL, '', '', '', NULL, NULL, '2013-04-14 15:56:27', NULL, NULL, NULL, NULL, NULL, NULL),
  (7682, 467, 207, 'HTML', '{\"html\":\"<div>\\n\\n        <div class=\\\"row-fluid\\\">\\n            <div class=\\\"span12\\\">\\n                <div class=\\\"span4\\\">\\n\\n                    <div id=\\\"product\\\" class=\\\"col\\\">\\n                        <h1>Imagine this:</h1>\\n                        <h2>Your users are able to customize start page of your application and create their own dashboards using your dashlets.</h2>\\n                        <h2>And you develop dashlets as regular Asp.Net user controls - ascx files. So cool ? And now even easy!</h2>\\n                        <p>\\n                            Dashboards are great ways for end users to understand and monitor current status of their business.\\n                        </p>\\n                        <p>\\n                            With JDash.Net, you allow them to create and design their own dashboards using desktop or mobile devices with simple drag-drops. Result is highly satisfied happy customers and reduced maintenance costs. \\n                        </p>\\n                        <h2>Key features\\n                        </h2>\\n                        <ul>\\n                            <li>Responsive design. Mobile and desktop fully supported.</li>\\n                            <li>Seemlessly integratable into your application.</li>\\n                            <li>Use your current Asp.Net skills for development.</li>\\n                            <li>Supports multiple layouts, not limited to only columns.</li>\\n                            <li>Database and browser independent. MsSQL and MySql included.</li>\\n\\n                        </ul>\\n                    </div>\\n\\n                </div>\\n                <div class=\\\"span4\\\">\\n\\n                    <div id=\\\"demo\\\" class=\\\"col\\\">\\n                        <h1>About this demo\\n                        </h1>\\n                        <p>\\n                            Purpose of this application is to demonstrate features and powerful architecture of JDash.Net. Demo is open source and <a target=\\\"_blank\\\" href=\\\"http://jdash.net/download\\\">download package</a> includes source code.\\n                        </p>\\n                        <ul>\\n                            <li>Have a look at your <a href=\\\"demo?id=473\\\">first dashboard</a>. </li>\\n                            <li>Click \\\"Home Dashboard\\\" button  on top of page to open a list of dashboards.</li>\\n                            <li>Use <i class=\\\"icon-th\\\"></i>Create link on toolbar to create a dashboard for you.</li>\\n                            <li>Use <i class=\\\"icon-plus-sign\\\"></i>Add Dashlet link to add some dashlets. We demonstrated image/javascript based charts from different vendors in Sample Visualizations tab.</li>\\n                            <li>Resize your browser or view this demo on your tablet or mobile phone to see responsive design capabilities.</li>\\n                        </ul>\\n                        <h2>About Dashlets\\n                        </h2>\\n                        <p>\\n                            Demo includes dashlets which may use 3rd party libraries or products. Please refer to their own documentation for licensing options of 3rd party libraries.\\n                        </p>\\n                    </div>\\n\\n                </div>\\n\\n                <div class=\\\"span4\\\">\\n\\n                    <div id=\\\"developer\\\" class=\\\"col\\\">\\n                        <h1>Developer notes\\n                        </h1>\\n                        <h2>It only takes 60 seconds to get started with JDash.Net</h2>\\n                        <h2></h2>\\n                        <p>\\n                            Simply, develop regular Asp.Net user controls – ascx. JDash.Net automatically converts your user controls to drag-drop dashlets which in turn your users use dashlets to design their dashboards. \\n                It only takes 60 seconds to get started with JDash.Net using your current Asp.Net knowledge. \\n                        </p>\\n                        <p>\\n                            No JavaScript skill is required. All page lifecycle and dynamic control creation is handled intelligently by JDash.Net.\\n                        </p>\\n                        <h2>Resources\\n                        </h2>\\n                        <ul>\\n                            <li><a target=\\\"_blank\\\" href=\\\"/download\\\">Download JDash.Net</a></li>\\n                            <li><a href=\\\"/demo?id=475\\\">View Online Tutorial</a></li>\\n                            <li><a target=\\\"_blank\\\" href=\\\"/Docs/JDashNetDevelopersGuide.pdf\\\">View Developers Guide</a> </li>\\n                            <li><a target=\\\"_blank\\\" href=\\\"http://forum.jdash.net\\\">Get support</a></li>\\n                        </ul>\\n                    </div>\\n                </div>\\n\\n            </div>\\n        </div>\\n    </div>\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\"],\"customCommands\":[],\"cssClass\":\"demo-content\"}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":0}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-04-16 15:28:21', NULL, NULL, NULL, NULL, NULL, NULL),
  (7704, 483, 250, 'Totals by Payment Types', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Country\\\"],\\\"Measures\\\":[\\\"Quantity\\\",\\\"Total_Price\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[{\\\"Column\\\":\\\"Quantity\\\",\\\"Direction\\\":1}],\\\"Skip\\\":-1,\\\"Take\\\":5}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone1\",\"pos\":2}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:52:27', NULL, NULL, NULL, NULL, NULL, NULL),
  (7705, 483, 250, 'Top Totals By Product & Payment Type', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Product\\\",\\\"Payment_Type\\\"],\\\"Measures\\\":[\\\"Quantity\\\",\\\"Total_Price\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[{\\\"Column\\\":\\\"Quantity\\\",\\\"Direction\\\":1}],\\\"Skip\\\":-1,\\\"Take\\\":5}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone2\",\"pos\":2}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:52:40', NULL, NULL, NULL, NULL, NULL, NULL),
  (7706, 483, 251, 'Quantity by Product', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Product\\\"],\\\"Measures\\\":[\\\"Quantity\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[],\\\"Skip\\\":-1,\\\"Take\\\":-1}\",\"chart\":\"{\\\"ChartType\\\":0,\\\"Header\\\":\\\"\\\",\\\"Footer\\\":\\\"\\\",\\\"Height\\\":\\\"\\\",\\\"HasPivotDimension\\\":false,\\\"Theme\\\":\\\"blue\\\"}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone2\",\"pos\":1}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:53:48', NULL, NULL, NULL, NULL, NULL, NULL),
  (7707, 483, 251, 'Product Totals by Year', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Product\\\"],\\\"Measures\\\":[\\\"Total_Price\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[],\\\"Skip\\\":-1,\\\"Take\\\":-1}\",\"chart\":\"{\\\"ChartType\\\":4,\\\"Header\\\":\\\"\\\",\\\"Footer\\\":\\\"\\\",\\\"Height\\\":\\\"\\\",\\\"HasPivotDimension\\\":false,\\\"Theme\\\":\\\"blue\\\"}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone1\",\"pos\":1}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:56:48', NULL, NULL, NULL, NULL, NULL, NULL),
  (7708, 483, 251, 'Quantity by State & Product', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"State\\\",\\\"Product\\\"],\\\"Measures\\\":[\\\"Quantity\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[],\\\"Skip\\\":-1,\\\"Take\\\":-1}\",\"chart\":\"{\\\"ChartType\\\":2,\\\"Header\\\":\\\"\\\",\\\"Footer\\\":\\\"\\\",\\\"Height\\\":\\\"\\\",\\\"HasPivotDimension\\\":true,\\\"Theme\\\":\\\"green\\\"}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone2\",\"pos\":0}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 12:58:49', NULL, NULL, NULL, NULL, NULL, NULL),
  (7709, 483, 251, 'Collected VAT by Product & Year', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Year\\\",\\\"Product\\\"],\\\"Measures\\\":[\\\"VAT\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[],\\\"Skip\\\":-1,\\\"Take\\\":-1}\",\"chart\":\"{\\\"ChartType\\\":1,\\\"Header\\\":\\\"\\\",\\\"Footer\\\":\\\"\\\",\\\"Height\\\":\\\"\\\",\\\"HasPivotDimension\\\":true,\\\"Theme\\\":\\\"blue\\\"}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section1\",\"zone\":\"zone1\",\"pos\":1}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 13:01:40', NULL, NULL, NULL, NULL, NULL, NULL),
  (7710, 483, 251, 'Total by Year', '{\"query\":\"{\\\"ConnectionName\\\":null,\\\"CatalogName\\\":null,\\\"CubeName\\\":\\\"Product Sales\\\",\\\"Dimensions\\\":[\\\"Year\\\"],\\\"Measures\\\":[\\\"Total_Price\\\"],\\\"Aggregations\\\":{},\\\"SourceData\\\":null,\\\"Sort\\\":[],\\\"Skip\\\":-1,\\\"Take\\\":-1}\",\"chart\":\"{\\\"ChartType\\\":4,\\\"Header\\\":\\\"\\\",\\\"Footer\\\":\\\"\\\",\\\"Height\\\":\\\"\\\",\\\"HasPivotDimension\\\":false,\\\"Theme\\\":\\\"green\\\"}\"}', '{\"builtInCommands\":[\"maximize\",\"restore\",\"remove\",\"refresh\"],\"customCommands\":[],\"cssClass\":\"nopad\"}', '{\"section\":\"section2\",\"zone\":\"zone1\",\"pos\":0}', NULL, NULL, NULL, '', '', 'KALITTE\\tansu', NULL, NULL, '2013-05-07 13:13:19', NULL, NULL, NULL, NULL, NULL, NULL);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

-- End of script
