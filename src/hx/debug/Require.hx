package hx.debug;

/**
 * A set of functions that signify failure when expected conditions aren't meant.
 * By Default, Require will throw an error message on a condition fail, but you can
 * change this to do whatever you want. 
 * Require functions return false when the condition is not met. Say you want to
 * throw an error on debug mode, but try and continue on release mode. You could
 * put each require in an if to gracefully handle the fail case.
 * 
 * @example 
 * // Throws an error message if the hero is beyond of the right end of the level.
 * Require.isTrue(hero.x < level.width, "The hero went through the wall");
 * 
 * Require.nonNull(enemy); // Throws "Unexpected null".
 * enemy.shoot();          // Won't crash.
 * 
 * @see Require.fail()
 * 
 * @author George
 */
class Require {
    
    /**
     * Called by failed Requires, throws an error by default. 
     * Can be redirected to any function.
     * 
     * @example Require.fail = haxe.Log.trace;    Require.isTrue(false, "test");// output: test
     * 
     * @param msg  An optional error message. If not passed a default one will be used
     */
    static public dynamic function fail(?msg:String, ?pos:PosInfos):Void {

        if (msg == null) msg = "failure";
        
        #if debug
        throw '${pos.fileName}[${pos.lineNumber}]: $msg';
        #else
        trace('${pos.fileName}[${pos.lineNumber}]: $msg');
        #end
    }
    
    static var _instance:AssertLogger = new AssertLogger(function(?msg:String, ?pos:PosInfos):Void { fail(msg, pos); } );
    
    /** Requires that the condition is true. */
    inline static public function isTrue(cond:Bool, msg = "Expected true", ?pos:PosInfos):Bool {
        
        return _instance.isTrue(cond, msg, pos); 
    }
    
    /** Requires that the condition is false. */
    inline static public function isFalse(cond:Bool, msg = "Expected false", ?pos:PosInfos):Bool {
        
        return _instance.isFalse(cond, msg, pos);
    }
    
    /** Requires that the value is null. */
    inline static public function isNull(value:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.isNull(value, msg, pos);
    }
    
    /** Requires that the value is not null. */
    inline static public function nonNull(value:Dynamic, msg = "Unexpected null", ?pos:PosInfos):Bool {
        
        return _instance.nonNull(value, msg, pos);
    }
    
    /**
     * Requires that the 'value' parameter is of the of the passed type 'type'.
     * @param value     The parent value to test
     * @param property  The property to assert
     */
    inline static public function has(value:Dynamic, property:String, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.has(value, property, msg, pos);
    }
    
    /**
     * Requires that the 'value' parameter is of the of the passed type 'type'.
     * @param value  The value to test
     * @param type   The type to test against
     */
    inline static public function is(value:Dynamic, type:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.is(value, type, msg, pos);
    }
    
    /**
     * Requires that the 'value' parameter is of the of the passed type 'type'.
     * @param value  The value to test
     * @param type   The type to test against
     */
    inline static public function isNot(value:Dynamic, type:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.isNot(value, type, msg, pos);
    }
    
    /** Requires that when Reflect.isObject(value) is true. */
    inline static public function isObject(value:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.isObject(value, msg, pos);
    }
    
    /**
     * Requires that when the value parameter is equal to the expected one.
     * 
     * @example Assert.equals(10, age);
     * 
     * @param expected  The expected value to check against
     * @param value     The value to test
     */
    inline static public function equals(value:Dynamic, expected:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.equals(value, expected, msg, pos);
    }

    /**
     * Requires that the value parameter is not the same as the expected one.
     * 
     * @example Assert.notEquals(10, age);
     * 
     * @param expected  The expected value to check against
     * @param value     The value to test
     */
    inline static public function notEquals(value:Dynamic, expected:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.notEquals(value, expected, msg, pos);
    }

    /**
     * Requires that the value parameter does match against the passed EReg instance.
     * 
     * @example Assert.match(~/x/i, "haXe");
     * 
     * @param pattern  The pattern to match against
     * @param value    The value to test
     */
    inline static public function match(pattern:EReg, token:Dynamic, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.match(pattern, token, msg, pos);
    }
    
    /**
     * Same as Assert.equals but considering an approximation error.
     * 
     * @example Assert.floatEquals(Math.PI, value);
     * 
     * @param expected  The expected value to check against
     * @param value     The value to test
     * @param approx    The approximation tollerance. Default is 1e-5
     */
    inline static public function floatEquals(value:Float, expected:Float, ?approx:Float, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.floatEquals(value, expected, approx, msg, pos);
    }
    
    /**
     * Requires that the array contains the match parameter.
     * @param match   The element that must be included in the tested array
     * @param values  The values to test
     */
    inline static public function contains<T>(list:Array<T>, item:T, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.contains(list, item, msg, pos);
    }
    
    /**
     * Requires that the test array does not contain the match parameter.
     * @param match   The element that must NOT be included in the tested array
     * @param values  The values to test
     */
    inline static public function notContains<T>(list:Array<T>, item:T, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.notContains(list, item, msg, pos);
    }
    
    /**
     * Requires that the expected value is contained in string.
     * @param match  The string value that must be contained in value
     * @param value  The value to test
     */
    inline static public function stringContains(str:String, token:String, ?msg:String, ?pos:PosInfos):Bool {
        
        return _instance.stringContains(str, token, msg, pos);
    }
    
    //} endregion                         STATIC
    // =============================================================================
}