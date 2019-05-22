//
// Copernicus
//
// Copyright (C) 2019 cy384
// All rights reserved.
//
// This software may be modified and distributed under the terms
// of the BSD license. See the LICENSE file for details.
//

using Toybox.Application;
using Toybox.WatchUi;

class CopernicusApp extends Application.AppBase
{
	function initialize()
	{
		AppBase.initialize();
	}

	function onStart(state)
	{
	}

	function onStop(state)
	{
	}

	function getInitialView()
	{
		return [new CopernicusView()];
	}

	function onSettingsChanged()
	{
		WatchUi.requestUpdate();
	}
}
