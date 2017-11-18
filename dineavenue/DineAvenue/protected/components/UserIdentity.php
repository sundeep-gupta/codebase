<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{    const ERROR_AUTH_FAILURE = 100;
    public $_id;
    
	/**
	 * Authenticates a user.
	 * The example implementation makes sure if the username and password
	 * are both 'demo'.
	 * In practical applications, this should be changed to authenticate
	 * against some persistent user identity storage (e.g. database).
	 * @return boolean whether authentication succeeds.
	 */
	public function authenticate() {
    $user = User::model()->findByAttributes(array('username' => $this->username));
    if($user && ($user->password === $user->encrypt($this->password))){
      $this->_id = $user->id;
      echo "Setting user id" . $this->_id;
      if(null === $user->lastvisit) {
        $lastLogin = time();
      }
      else {
        $lastLogin = strtotime($user->lastvisit);
      }
      $this->setState('lastLoginTime', $lastLogin);
      $this->errorCode = self::ERROR_NONE;
    }
    else {
      $this->errorCode = self::ERROR_AUTH_FAILURE;
    }
		return !$this->errorCode;
	}
  public function getId() {
      return $this->_id;
    }
   
}