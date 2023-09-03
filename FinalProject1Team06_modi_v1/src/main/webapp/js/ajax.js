/**
 * ajax.js
 */

// AJAX 객체(XMLHttpRequest 객체) 변수
var ajax = null;

// AJAX 객체(XMLHttpRequest 객체) 생성 함수
function createAjax()
{
	// ActiveXObject 를 지원하는 브라우저라면...
	/*
	if (window.ActiveXObject)							//-- IE 7 이전
	{
		// 이와 같은 방식으로 XMLHttpRequest 객체를 생성해서 반환해라~!!!
		// (ActiveXObject 객체 → XMLHttpRequest 객체를 대리할 수 있는 객체)
		return new ActiveXObject("Msxml2.XMLHTTP");
		//return new ActiveXObject("Microsoft.XMLHTTP");
		
	}
	else												//-- 그 외 브라우저
	{
		if (window.XMLHttpRequest)						//-- XMLHttpRequest 지원 브라우저
		{
			// 이와 같은 방식으로 XMLHttpRequest 객체를 생성해서 반환해라~!!!
			return new XMLHttpRequest();
			
		}
		else											//-- AJAX 를 지원하지 않는 브라우저
		{
			return null;

		}

	}
	*/
	
	if (window.ActiveXObject)
	{
		return new ActiveXObject("Msxml2.XMLHTTP");
	}
	else if (window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	else
	{
		return null;
	}
	
	
	
	
}