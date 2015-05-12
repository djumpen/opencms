<?php
/*******************************************************************************
*                                     Timer class                              *
*                             Created: 27th January 2010                       *
*                             ©Copyright Jay Gilford 2010                      *
*                              http://www.jaygilford.com                       *
*                            email: jay [at] jaygilford.com                    *
*******************************************************************************/
 
 
class timer {
    private $_start = 0;
    private $_elapsed = 0;
    private $_running = false;
 
    /**
     * timer::construct()
     * set the timer running of $start is true
     * 
     * @param bool $start
     * @return true
     */
    public function __construct($start = false) {
        // If true is passed, start the timer immediately
        if($start === true)
            $this->start();
 
        return true;
    }
 
    /**
     * timer::start()
     * start the timer
     * 
     * @return true
     */
    public function start() {
        // Reset timer
        $this->reset(false);
        // Set status to running
        $this->_running = true;
        // Set timer running
        $this->_start = $this->_time();
 
        return true;
    }
 
    /**
     * timer::stop()
     * stops the timer and returns the total time elapsed
     * 
     * @return mixed
     */
    public function stop() {
        // If the timer isn't running return false
        if($this->_running === false)
            return false;
 
        // Set the final elapsed time and stop the timer
        $this->_elapsed = $this->_get_elapsed();
        $this->_running = false;
        $this->_start = 0;
 
        // Return the timers total elapsed time
        return $this->_elapsed;
    }
 
    /**
     * timer::pause()
     * pauses/unpauses the timer
     * 
     * @return NULL
     */
    public function pause() {
        // If the timer isn't running return false
        if($this->_running === false)
            return false;
 
        // If the timer is paused set the timer from the current time
        if($this->_start == 0) {
            $this->_start = $this->_time();
 
        // Otherwise add the currently elapsed time to the total
        // elapsed time and pause the timer
        }else{
            $this->_elapsed = $this->_get_elapsed();
            $this->_start = 0;
        }
    }
 
    /**
     * timer::elapsed()
     * returns the total time elapsed since the timer started
     * 
     * @return float
     */
    public function elapsed() {
        return $this->_get_elapsed();
    }
 
    /**
     * timer::reset()
     * resets the timers variables back to default
     * 
     * @param bool $start
     * @return
     */
    public function reset($start = false) {
        // Reset all variables
        $this->_start = 0;
        $this->_elapsed = 0;
        $this->_running = false;
 
        // If $start is true restart the timer immediately
        if($start === true)
            $this->start();
 
        return true;        
    }
 
    /**
     * timer::_time()
     * returns the current unix time (with milliseconds)
     * 
     * @return float
     */
    private function _time() {
    	$time = explode(' ', microtime());
    	$time =  (float)$time[1] + $time[0];
        return $time;
    }
 
    /**
     * timer::_get_elapsed()
     * Returns the current elapsed time
     * 
     * @return float
     */
    private function _get_elapsed() {
        if($this->_running === false || $this->_start == 0)
            return $this->_elapsed;
 
        return $this->_elapsed + ($this->_time() - $this->_start);
    }
}