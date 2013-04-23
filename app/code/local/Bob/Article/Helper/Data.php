<?php

class Bob_Article_Helper_Data extends Mage_Core_Helper_Abstract
{
    public function timeCountdown($time,$status)
    {
        $unix_time = $time;   
        $unix_time = strtotime($unix_time);
        $current_time = time();
        $diff = $unix_time - $current_time;
        //$diff should be positive and not 0
        if( 1 > $diff ){
           echo $status;
        } else {
            $y = round($diff/31536000, 0 , PHP_ROUND_HALF_DOWN);
            $m = $diff/86400/30 % 12;
            $w = $diff / 86400 / 7 % 4;
            $d = $diff / 86400 % 7;
            $h = $diff / 3600 % 24;
            if($y > 0){
            $we = "{$y} years, {$m} months"; 
                if($y == 1){
                    $we = "{$y} year, {$m} months";
                    if($m == 1){
                        $we = "{$y} year, {$m} month";
                    }
                    elseif($m < 1){
                        $we = "{$y} year";
                    }
                }
                else{
                    $we = "{$y} yearss, {$m} months";
                    if($m == 1){
                        $we = "{$y} years, {$m} month";
                    }
                    elseif($m < 0){
                        $we = "{$y} years";
                    }
                }
                        
           }
           else{
            if($m > 0){
                $we = "{$m} months, {$w} weeks"; 
                if($m == 1){
                    $we = "{$m} month, {$w} weeks";
                    if($w == 1){
                        $we = "{$m} month, {$w} week"; 
                    }
                    elseif($w < 1){
                        $we = "{$m} month";
                    } 
                }
                else{
                    $we = "{$m} months, {$w} weeks";
                    if($w == 1){
                        $we = "{$m} months, {$w} week"; 
                    }
                    elseif($w < 1){
                        $we = "{$m} months";
                    } 
                }           
            }
            else{
                if( $w > 0){ 
                    if($w == 1){
                        $we = "{$w} week, {$d} days";
                        if($d == 1){
                            $we = "{$w} week, {$d} day";
                        }
                        elseif($d < 1){
                            $we = "{$w} week";
                        }
                    }
                    else{
                        $we = "{$w} weeks, {$d} days";
                        if($d == 1){
                            $we = "{$w} weeks, {$d} day";
                        }
                        elseif($d < 1){
                            $we = "{$w} weeks";
                        }
                    }                
                }        
               else{
                $we = "{$d} days, {$h} hours";
                if($d == 1){
                    $we = "{$d} day, {$h} hours";
                    if($h == 1){
                        $we = "{$d} day, {$h} hour";
                    }
                    elseif($h < 1){
                        $we = "{$d} day";
                    }
                }
                elseif($d < 1){
                    $we = "{$h} hours";
                    if($h == 1){
                        $we = "{$h} hour";
                    }
                    elseif($h < 1){
                        $we = "just a few minutes more";
                    }
                }
                else{
                    $we = "{$d} days, {$h} hours";
                    if($h == 1){
                        $we = "{$d} dasy, {$h} hour";
                    }
                    elseif($h < 1){
                        $we = "{$d} days";
                    }
                }
               }
           }
           }      
           
        return $we;
        }
    }
    
    public function dateFormat($date){
        $format = Date('M. d, Y', strtotime($date));
        return $format;
    }
    
    public function getTimeWeight($date){
        $diff = strtotime($date) - time();
        if($diff > 1){
            return (int)($diff/60);
        } else{
            return 0;
        }
    }
}