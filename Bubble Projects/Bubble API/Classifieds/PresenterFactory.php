<?php

class PresenterFactory {
    
    public static function get_presenter($model) {
	# TODO: check if $instance belong to framework

	# if yes...
	$presenter = $model->get_presenter_name();
	require_once(MVC_LIB.'/Bubble/Classifieds/view/'.$presenter.'.php');
	$presenter .= 'View';

	$pr = new $presenter($model);
	return $pr;
    }

}

?>