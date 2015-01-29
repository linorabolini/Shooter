package com.core.components
{
	import com.core.GameObject;

	public interface Component
	{
		function setup(g:GameObject):void;
		function update(g:GameObject, delta:Number):void;
		function dispose(g:GameObject):void;
		function activate(g:GameObject):void;
		function deactivate(g:GameObject):void;
	}
}