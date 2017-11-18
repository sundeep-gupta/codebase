<?php

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
  'theme' => 'classic',
  'defaultController' => 'restaurant',
	'name'=>'Dine Avenue...',

	// preloading 'log' component
	'preload'=>array('log'),

	// autoloading model and component classes
	'import'=>array(
		'application.models.forms.*',
    'application.models.tables.*',
		'application.components.*',
    'application.controllers.*',
	),

	'modules'=>array(
		// uncomment the following to enable the Gii tool

		'gii'=>array(
			'class'=>'system.gii.GiiModule',
			'password'=>'password',
		 	// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
		),

	),

	// application components
	'components'=>array(
    'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
      'loginUrl' => array( '/user/login')
		),

    'session' => array(
        'class' => 'CHttpSession',
        'cookieMode' => 'only',
        'timeout' => '300',
    ),
    'authManager' => array(
        'class' => 'CDbAuthManager',
        'connectionID' => 'db',
        'assignmentTable' => '{{auth_assignment}}',
        'itemTable' => '{{auth_item}}',
        'itemChildTable' => '{{auth_item_child}}'
    ),
		// uncomment the following to enable URLs in path-format
		/*
		'urlManager'=>array(
			'urlFormat'=>'path',
			'rules'=>array(
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
			),
		),
		*/
		'db'=>array(
			'connectionString' => 'mysql:host=localhost;dbname=x2_test',
			'emulatePrepare' => true,
			'username' => 'root',
			'password' => 'password',
			'charset' => 'utf8',
      'tablePrefix' => 'x2_'
		),

		'errorHandler'=>array(
			// use 'site/error' action to display errors
            'errorAction'=>'restaurant/error',
        ),
		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				// uncomment the following to show log messages on web pages
				/*
				array(
					'class'=>'CWebLogRoute',
				),
				*/
			),
		),
    'mail' => array (
        'class' => 'ext.yii-mail.YiiMail',
            'transportType'=>'smtp', /// case sensitive!
            'transportOptions'=>array(
                'host'=>'smtp.gmail.com',
                'username'=>'sundeep.techie@gmail.com',
                'password'=>'password',
                'port'=>'465',
                'encryption'=>'ssl',
            ),
        'viewPath' => 'application.views.mail',
        'logging' => true,
        'dryRun' => false,
    ),
	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'sundeep.techie@gmail.com',
    'copyright' => 'Copyright &copy;'. date('Y') .', DineAvenue.com. All Rights Reserved.',
    'companyMessage' => 'An iStack Venture',
    'companyName' => 'iStack',
    'companyUrl' => 'www.istack.in',
	),

);