<?php

class Form {
    
    protected $name;
    protected $action;
    protected $method;
    protected $attr;
	protected $title;
	protected $data;
    public function __construct($form_name, $action, $method='POST', $attr=array()) {
		$this->name = $form_name;
		$this->action = $action;
		$this->method = $method;
		$this->attr  = $attr;
		$this->data = array();
    }
	public function set_title($title) { $this->title = $title; }
	public function add_element($element) {array_push($this->data, $element);}
    public function add_submit_button() {
    }

    public function add_password_text() {
    }

    public function add_input_text() {
    }

    public function add_hidden_field() {

    }
    public function add_button() {
    }

    public function add_file_upload() {
    }

    public function add_label() {
    }

	public function get_html_text() {
		$html = '<form name="'.$this->name.'" action="'.$this->action.'" method="'.$this->method.'"';
		if($this->attr != null) {
			foreach ($this->attr as $key=>$value) {
				$html .= " ".$key .'="'.$value.'"';
			}
		}
		$html .= '>';
		if(isset($this->title)) {
			$html .= '<h1>'.$this->title.'</h1><br/>';
		}
		if($this->data != null) {
			foreach ($this->data as $element) {
				if (is_string($element)) {
					$html .= $element;
				} else {
					$html .= $element->get_html_text();
				}
			}
		}

		$html .= '</form>';
		return $html;
	}
}


class Input {
	protected $name;
	protected $type;
	protected $value;
	protected $attr;
	protected $data;
	protected $label;

	public function __construct($name, $type, $value = '', $attr) {
		$this->name = $name;
		$this->type = $type;
		$this->value = $value;
		$this->attr = $attr;
		$this->data = array();
			
	}
	public function set_label($label) {
		$this->label = $label;
	}
	public function add_data($data){
		array_push($this->data, $data);
	}

	public function get_html_text() {
		$html = '';
		if(isset($this->label)) {
			$html .= '<label for="' . $this->attr['id'] . '">' . $this->label . '</label>';
		}
		$html .= '<div id="d_'.$this->name.'">';
		$html .= '<input name="'.$this->name.'" type="'.$this->type.'" value="'.$this->value.'"';
		if($this->attr != null) {
			foreach($this->attr as $key => $value) {
				$html .= ' ' . $key . '="' . $value . '"';
			}
		}
		$html .= '>';
		if($data != null) {
			foreach ($data as $element) {
				if (is_string($element)) {
					$html .= $element;
				} else {
					$html .= $element->get_html_text();
				}
			}
		}

		$html .= '</div></input><br/>'."\n";
		return $html;
	}

}

?>
