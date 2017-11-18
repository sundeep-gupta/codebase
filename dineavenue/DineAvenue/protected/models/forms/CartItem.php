<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of CartItem
 *
 * @author skgupta
 */
class CartItem {
  protected $id;
  protected $quantity;
  protected $price;

  public function __construct($id, $quantity = 0, $price = 0) {
    $this->id = $id;
    $this->quantity = $quantity;
    $this->price = $price;
  }

  public function getId() { return $this->id; }

  public function getQuantity() { return $this->quantity; }

  public function getPrice() {
    return $this->price;
  }

  public function getTotal() {
    return $this->quantity * $this->price;
  }

  public function setQuantity($quantity) {
    $this->quantity = $quantity;
  }

  public function alterQuantity($diff) {
    $this->quantity = $this->quantity + $diff;
    if ($this->quantity < 0) {
      $this->quantity = 0;
    }
  }

  public function setPrice($price) {
    $this->price = $price;
    if ($this->price < 0) {
      $this->price = 0;
    }
  }

  public function toArray() {
    return array('id' => $this->id, 'quantity' => $this->quantity, 'price' => $this->price, 'total' => $this->getTotal());
  }

}

?>
