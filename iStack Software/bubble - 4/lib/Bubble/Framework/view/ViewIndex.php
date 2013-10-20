<?
class ViewIndex {
    protected $model;
    protected $result;
    public function  __construct($model, $result) {
	$this->model = $model;
	$this->result = $result;
    }
    
    public function display() {
	echo 'Test Framework';
    }
}

?>