<?php

class PresenterFactory {
    
    public static function getPresenter($instance, $result) {
	# TODO: check if $instance belong to framework

	# if yes...
	$presenter = $instance->getPresenterName();
	require_once('lib/Bubble/'.PRJ_NAME.'/view/'.$presenter.'.php');
	$pr = new $presenter($instance, $result);
	return $pr;
    }

}

?>