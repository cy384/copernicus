//
// Copernicus
//
// Copyright (C) 2019 cy384
// All rights reserved.
//
// This software may be modified and distributed under the terms
// of the BSD license. See the LICENSE file for details.
//

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Math;
using Toybox.Application;

class CopernicusView extends WatchUi.WatchFace
{
	var awake;
	var arbor;
	var seconds;
	var dark;

	function initialize()
	{
		WatchUi.WatchFace.initialize();

		awake = false;
		arbor = true;
		seconds = true;
		dark = true;
	}

	function onLayout(dc)
	{
	}

	// "Called when this View is brought to the foreground. Restore
	// the state of this View and prepare it to be shown. This includes
	// loading resources into memory."
	function onShow() {
	}

	function drawMinutesMarks(dc)
	{
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		var iX, iY, oX, oY;
		var furtherOuterRad = min * 0.37;
		var outerRad = min * 0.35;
		var innerRad = min * 0.33;

		// circles
		dc.setPenWidth(1);
		dc.drawCircle(width/2.0, height/2.0, outerRad);
		dc.drawCircle(width/2.0, height/2.0, innerRad);

		if (dark)
		{
			dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
		}
		else
		{
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		}

		// minute marks
		dc.setPenWidth(1);
		for (var x = 0; x <= 60; x += 1) {
			var angle = x * (Math.PI / 30.0);

			// make the 5 minute marks longer
			if (x % 5 == 0)
			{
				oX = width/2.0 + Math.sin(angle)*furtherOuterRad;
				oY = height/2.0 + Math.cos(angle)*furtherOuterRad;
			}
			else
			{
				oX = width/2.0 + Math.sin(angle)*outerRad;
				oY = height/2.0 + Math.cos(angle)*outerRad;
			}

			iX = width/2.0 + Math.sin(angle)*innerRad;
			iY = height/2.0 + Math.cos(angle)*innerRad;

			dc.drawLine(iX, iY, oX, oY);
		}
	}

	function drawMinuteHand(dc)
	{
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		var clockTime = System.getClockTime();

		var hourRad = min * 0.18;
		var pointerOut = min * 0.42;
		var pointerIn = min * 0.36;

		// get the angle for minutes
		var angle = (clockTime.min / 60.0) * (-2.0 * Math.PI);
		angle += Math.PI;

		// center of the hour circle
		var cX = width/2.0 + Math.sin(angle)*hourRad;
		var cY = height/2.0 + Math.cos(angle)*hourRad;

		// points for the hour nub
		var pox = width/2.0 + Math.sin(angle)*pointerOut;
		var poy = height/2.0 + Math.cos(angle)*pointerOut;

		var pix = width/2.0 + Math.sin(angle)*pointerIn;
		var piy = height/2.0 + Math.cos(angle)*pointerIn;

		// draw the hand
		dc.setPenWidth(4);
		dc.drawLine(pix, piy, pox, poy);
		dc.drawCircle(cX, cY, min/4.8);

		if (arbor)
		{
			// draw the arbor
			dc.fillCircle(width/2.0, height/2.0, min*0.03);
		}
	}

	function drawHourHand(dc)
	{
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		var clockTime = System.getClockTime();

		var hourRad = min * 0.13;
		var pointerOut = min * 0.34;
		var pointerIn = min * 0.30;

		// get the angle for the hour
		var angle = ((clockTime.hour % 12) / 12.0) * (-2.0 * Math.PI);
		angle += Math.PI;

		// add the minutes
		angle -= (clockTime.min / 60.0) * (Math.PI / 6);

		// center of the circle
		var cX = width/2.0 + Math.sin(angle)*hourRad;
		var cY = height/2.0 + Math.cos(angle)*hourRad;

		// points for the nub
		var pox = width/2.0 + Math.sin(angle)*pointerOut;
		var poy = height/2.0 + Math.cos(angle)*pointerOut;

		var pix = width/2.0 + Math.sin(angle)*pointerIn;
		var piy = height/2.0 + Math.cos(angle)*pointerIn;

		dc.setPenWidth(5);
		dc.drawLine(pix, piy, pox, poy);
		dc.fillCircle(cX, cY, min/5.3);
	}

	function drawSecondHand(dc)
	{
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		var clockTime = System.getClockTime();

		var secondRad = min * 0.45;
		var secondRadBack = min * 0.2;

		// get the angle for seconds
		var angle = (clockTime.sec / 60.0) * (-2.0 * Math.PI);
		angle += Math.PI;

		// tip of the second hand
		var slx = width/2.0 + Math.sin(angle)*secondRad;
		var sly = height/2.0 + Math.cos(angle)*secondRad;

		// draw second hand
		dc.setPenWidth(2);
		dc.drawLine(width/2.0, height/2.0, slx, sly);

		// back side of second hand
		var back = angle + Math.PI;
		var bx = width/2.0 + Math.sin(back)*secondRadBack;
		var by = height/2.0 + Math.cos(back)*secondRadBack;

		dc.setPenWidth(2);
		dc.drawLine(width/2.0, height/2.0, bx, by);

		// make a triangle shape on the back
		var left = back - 0.02*Math.PI;
		var right = back + 0.02*Math.PI;

		dc.fillPolygon([[width/2.0, height/2.0],
			[width/2.0 + Math.sin(left)*secondRadBack,
			height/2.0 + Math.cos(left)*secondRadBack],
			[width/2.0 + Math.sin(right)*secondRadBack,
			height/2.0 + Math.cos(right)*secondRadBack]]);

		if (arbor)
		{
			// draw the arbor
			dc.fillCircle(width/2.0, height/2.0, min*0.02);
		}
	}

	function drawDots(dc)
	{
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		// top dots
		if (dark)
		{
			// dark variant has two dots on top
			dc.fillCircle(width * 0.46, height * 0.04, min/33);
			dc.fillCircle(width * 0.54, height * 0.04, min/33);
		}
		else
		{
			dc.fillCircle(width * 0.50, height * 0.04, min/33);
		}

		// other cardinal dots
		dc.fillCircle(width * 0.50, height * 0.96, min/33);
		dc.fillCircle(width * 0.96, height * 0.50, min/33);
		dc.fillCircle(width * 0.04, height * 0.50, min/33);

		if (!dark)
		{
			// light variant has more dots at 45* angles
			// aka sqrt(3)/2
			var ord = 0.8660254037844386;

			// hour dots
			dc.fillCircle(width*0.5*(1 + 0.92*ord), height*0.5*(1 + 0.92*0.5), min/40);
			dc.fillCircle(width*0.5*(1 + 0.92*ord), height*0.5*(1 - 0.92*0.5), min/40);
			dc.fillCircle(width*0.5*(1 - 0.92*ord), height*0.5*(1 + 0.92*0.5), min/40);
			dc.fillCircle(width*0.5*(1 - 0.92*ord), height*0.5*(1 - 0.92*0.5), min/40);
			
			dc.fillCircle(width*0.5*(1 + 0.92*0.5), height*0.5*(1 + 0.92*ord), min/40);
			dc.fillCircle(width*0.5*(1 + 0.92*0.5), height*0.5*(1 - 0.92*ord), min/40);
			dc.fillCircle(width*0.5*(1 - 0.92*0.5), height*0.5*(1 + 0.92*ord), min/40);
			dc.fillCircle(width*0.5*(1 - 0.92*0.5), height*0.5*(1 - 0.92*ord), min/40);
		}
	}

	// update event handler
	function onUpdate(dc)
	{
		dark = Application.getApp().getProperty("display_dark");
		arbor = Application.getApp().getProperty("display_arbor");
		seconds = Application.getApp().getProperty("display_seconds");
		
		var width = dc.getWidth();
		var height = dc.getHeight();

		var min;
		if (width > height)
		{
			min = height;
		}
		else
		{
			min = width;
		}

		// bg
		if (dark)
		{
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		}
		else
		{
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		}
		dc.fillRectangle(0, 0, width, height);

		// draw all dots
		dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
		drawDots(dc);

		// minute rings with marks
		if (dark)
		{
			dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
		}
		else
		{
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		}
		drawMinutesMarks(dc);

		// draw hour hand
		dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
		drawHourHand(dc);

		// draw minute hand
		if (dark)
		{
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		}
		else
		{
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		}
		drawMinuteHand(dc);

		// if we're awake, draw the second hand
		if (awake && seconds)
		{
			if (dark)
			{
				dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
			}
			else
			{
				dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
			}

			drawSecondHand(dc);
		}
	}

	// "Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory."
	function onHide() {
	}

	// called when we enter sleep
	function onEnterSleep()
	{
		awake = false;
		WatchUi.requestUpdate();
	}

	// called when we exit sleep
	function onExitSleep()
	{
		awake = true;
	}
}
