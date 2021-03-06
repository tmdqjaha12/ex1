  
// 범용성 있는 자바스크립트
String.prototype.replaceAll = function(org, dest) {
	return this.split(org).join(dest);
}

function getUriParams(uri) {
	uri = uri.trim();
	uri = uri.replaceAll('&amp;', '&');
	if (uri.indexOf('#') !== -1) {
		var pos = uri.indexOf('#');
		uri = uri.substr(0, pos);
	}

	var params = {};

	uri.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) {
		params[key] = value;
	});
	return params;
}

function jq_attr($el, attrName, elseValue) {
	var value = $el.attr(attrName);

	if (value === undefined || value === "") {
		return elseValue;
	}

	return value;
}

function isCellphoneNo(str) {
	if ( str.substr(0, 1) != '0' ) {
		return false;
	}
	
	return isNumber(str);
}

function isNumber(n) {
	return /^-?[\d.]+(?:e-?\d+)?$/.test(n);
}

function getHtmlEncoded(raw) {
    return raw.replace(/[\u00A0-\u9999<>\&]/gim, function(i) {
        return '&#'+i.charCodeAt(0)+';';
    });
}


var nowLoading = false;

function startLoading() {
    nowLoading = true;
    
    $html.addClass('loading-box-actived');
}

function endLoading() {
    nowLoading = false;
    
    $html.removeClass('loading-box-actived');
}

function isNowLoading() {
    return nowLoading;
}

function ListSideBar__init() {
	$('.list-side-bar .btn-toggle-list-side-bar').click(function() {
		var $this = $(this);

		if ($this.hasClass('active')) {
			$this.removeClass('active');
			$('.list-side-bar').removeClass('active');
		} else {
			$this.addClass('active')
			$('.list-side-bar').addClass('active');
		}
	});
}