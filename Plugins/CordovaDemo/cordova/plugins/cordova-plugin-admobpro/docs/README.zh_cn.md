
# AdMob Plugin Pro ����˵�� #

�� Javascript ���� AdMob ���׬Ǯ��һ�д���㶨 ��

���㣺
- [x] ��򵥵�API��һ�д���㶨�����ʾ��
- [x] ֧�ֹ������Banner����ȫ����棨Interstitial����
- [x] ����ͨ��AdMob�н�֧�ֶ��������硣
- [x] ���ֹ�����ߴ磬���������Զ���ߴ硣
- [x] ���Թ̶��������Ļ���˻�ײ���Ҳ��������ģʽ��
- [x] �����Ĺ����֣�����������ָ��λ����ʾ��
- [x] ���������������ܹ�����Զ���Ӧ��
- [x] ֧�����µ� iOS SDK��
- [x] ֧�����µ� Android Google play services��
- [x] ����ά����ʱ������֧�ֵ�λ��

���ݣ�
- [x] Apache Cordova
- [x] Intel XDK / Crosswalk
- [x] IBM Worklight
- [x] Google Chrome App
- [x] Adobe PhoneGap Build

֧�ֹ�����磺
- [x] AdMob
- [x] DoubleClick
- [x] Facebook AudienceNetwork
- [x] Flurry
- [x] iAd
- [x] InMobi
- [x] Millennial Media
- [x] MobFox

������ʾ����������� 2 ���µ�����ͳ�ƣ�
- [x] ʹ�� AdMob Plugin Pro���ȿ�Դ�汾�и��ߵ�����ʣ�fill rate����
- [x] ʹ��ȫ����棬�ȹ������������ߣ��ߴ� 5-10 ���� 

���ʣ�
- �����ʣ�Fill rate��: �����App�й����ʾ�Ĵ��������Թ������Ĵ�����
- �����ʣ�RPM��: ��ʾ 1000 �ι������档
- Intel XDK: Intel �� HTML5 �ƶ�Ӧ�ÿ����������Ʒ������ƶ˹������������֧�ֵ������ϵĵ����������
- Adobe PhoneGap Build: Adobe��HTML5��������Ʒ��񣬽��ܷ����������ֻ����ʹ�þ��������׼�Ĳ����

���ţ�
- ����Ƽ���Telerik�������� Verified Plugins Marketplace. [���� ...](http://plugins.telerik.com/plugin/admob)
- ����Ƽ���William SerGio�������� code project (20 Jun 2014), [���� ...](http://www.codeproject.com/Articles/788304/AdMob-Plugin-for-Latest-Version-of-PhoneGap-Cordov)
- ����Ƽ���Arne�������� Scirra Game Dev Forum (07 Aug, 2014), [���� ...](https://www.scirra.com/forum/plugin-admob-ads-for-crosswalk_t111940)
- ����Ƽ���Intel XDK�Ŷ� (08/22/2014), [���� ...](https://software.intel.com/en-us/html5/articles/adding-google-play-services-to-your-cordova-application)
- ����Ƽ���Scirra Construct 2 (09/12/2014)�ٷ��汾����, [read more ...](https://www.scirra.com/construct2/releases/r180)

## ���ʹ�� ##

���ʹ�� [Cordova �����й���](https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface)���������²��贴����Ŀ����Ӳ����
```c
cordova create <project_folder> com.<company_name>.<app_name> <AppName>
cd <project_folder>
cordova platform add android
cordova platform add ios

cordova plugin add com.google.cordova.admob

// copy the demo html file to www
rm -r www/*; cp plugins/com.google.cordova.admob/test/index.html www/

// connect device or run in emulator
cordova prepare; cordova run android; cordova run ios;

// or import into Xcode / eclipse
```

���ʹ�� Intel XDK���������²��������
Project -> CORDOVA 3.X HYBRID MOBILE APP SETTINGS -> PLUGINS AND PERMISSIONS -> Third-Party Plugins ->
Add a Third-Party Plugin -> Get Plugin from the Web, input:
```
Name: AdMobPluginPro
Plugin ID: com.google.cordova.admob
[x] Plugin is located in the Apache Cordova Plugins Registry
```

## �������ֵ����� ##

> ���� 1: ͨ�� AdMob ��վ��������Ӧ�Ĺ����λ ID

```javascript
// ����ƽ̨���Զ�ѡ����Ӧ�Ĺ�� ID
    var admobid = {};
    if( /(android)/i.test(navigator.userAgent) ) { // for android
		admobid = {
			banner: 'ca-app-pub-xxx/xxx', // or DFP format "/6253334/dfp_example_ad"
			interstitial: 'ca-app-pub-xxx/yyy'
        };
    } else if(/(ipod|iphone|ipad)/i.test(navigator.userAgent)) { // for ios
		admobid = {
			banner: 'ca-app-pub-xxx/zzz', // or DFP format "/6253334/dfp_example_ad"
			interstitial: 'ca-app-pub-xxx/kkk'
		};
    } else { // for windows phone
		admobid = {
			banner: 'ca-app-pub-xxx/zzz', // or DFP format "/6253334/dfp_example_ad"
			interstitial: 'ca-app-pub-xxx/kkk'
		};
    }
```

> ���� 2: һ�д��룬��ʾ�����

```javascript
// ��ʾ�������Ĭ���ڶ��˵����ܹ����
if(AdMob) AdMob.createBanner( admobid.banner );

// ����, �ڵײ���ʾ�����
if(AdMob) AdMob.createBanner( {
	adId:admobid.banner, 
	position:AdMob.AD_POSITION.BOTTOM_CENTER, 
	autoShow:true} );

// ���ߣ��Ѹ���ģʽ���ڵײ���ʾ������
if(AdMob) AdMob.createBanner( {
	adId:admobid.banner, 
	adSize:'MEDIUM_RECTANGLE', 
	overlap:true, 
	position:AdMob.AD_POSITION.BOTTOM_CENTER, 
	autoShow:true} );

// ���ߣ���ָ����λ�ã���ʾָ����С�Ĺ��
if(AdMob) AdMob.createBanner( {
	adId:admobid.banner, 
	adSize:'CUSTOM',  width:200, height:200, 
	overlap:true, 
	position:AdMob.AD_POSITION.POS_XY, x:100, y:200, 
	autoShow:true} );

```

> ���� 3: ׼��ȫ����棬������Ҫ��ʱ����ʾ

```javascript
// �ں�̨׼�������Դ�����磬��ĳ����Ϸ�ؿ���ʼ��ʱ��
if(AdMob) AdMob.prepareInterstitial( {adId:admobid.interstitial, autoShow:false} );

// ��ʾȫ����棬���磬��ĳ����Ϸ�ؿ�������ʱ��
if(AdMob) AdMob.showInterstitial();
```

## ���������� ##
�μ�Դ���� [test/index.html] (https://github.com/floatinghotpot/cordova-admob-pro/blob/master/test/index.html).

## API ���� ##

### ���� ###
```javascript```
AdMob.setOptions(options);

AdMob.createBanner(adId/options, success, fail);
AdMob.removeBanner();
AdMob.showBanner(position);
AdMob.showBannerAtXY(x, y);
AdMob.hideBanner();

AdMob.prepareInterstitial(adId/options, success, fail);
AdMob.showInterstitialAd();
```

### �¼� ###
> **�﷨**: document.addEventListener(event_name, callback);

```javascript
// �����¼��������ڹ������ȫ�����
'onAdFailLoad'
'onAdLoaded'
'onAdPresent'
'onAdLeaveApp'
'onAdDismiss'

// �����¼��������ڹ���������������ϣ�������������¼�
'onBannerFailedToReceive'
'onBannerReceive'
'onBannerPresent'
'onBannerLeaveApp'
'onBannerDismiss'
    
// �����¼���������ȫ����棬���������ϣ�������������¼�  
'onInterstitialFailedToReceive'
'onInterstitialReceive'
'onInterstitialPresent'
'onInterstitialLeaveApp'
'onInterstitialDismiss'
```

## ���� ##

### AdMob.setOptions(options) ###

> **��;**: �������ķ�����������Ĭ�ϲ��������е���Ŀ���ǿ�ѡ�ģ����û������Ĭ��ֵ��

**����**:
- **options**, *json object*, mapping key to value.

���� **options** �� key/value:
- **license**, *string*, ������Ȩ��, �Ƴ� 2% �Ĺ����������
- **bannerId**, *string*, ���ù������Ĭ�Ϲ�� ID������ 'ca-app-pub-xxx/xxx'
- **interstitialId**, *string*, ����ȫ������Ĭ�Ϲ�� ID������ 'ca-app-pub-xxx/xxx'
- **adSize**, *string*, ���ù�����Ĵ�С��Ĭ��ֵ:'SMART_BANNER'. ���������µ�ĳ��: (Ч���μ���ͼ)
```javascript
'SMART_BANNER', // �Ƽ����Զ���Ӧ��Ļ��С�͸߶�
'BANNER', 
'MEDIUM_RECTANGLE', 
'FULL_BANNER', 
'LEADERBOARD', 
'SKYSCRAPER', 
'CUSTOM', // �����Զ����С����Ҫָ������ 'width' �� 'height'
```
- **width**, *integer*, ������Ŀ��, ��Ҫָ�� *adSize*:'CUSTOM'. Ĭ��ֵ: 0
- **height**, *integer*, ������ĸ߶ȣ���Ҫָ�� *adSize*:'CUSTOM'. Ĭ��ֵ: 0
- **overlap**, *boolean@, ����ģʽ����������������Web���ݵ����棬����Ļ����Webview���ϻ��������ƣ������ڵ�. Ĭ��ֵ:false
- **position**, *integer*, �������λ�ã�, Ĭ��ֵ:TOP_CENTER ��������У�. ��ѡ��ֵ������: 
```javascript
AdMob.AD_POSITION.NO_CHANGE  	= 0,
AdMob.AD_POSITION.TOP_LEFT 		= 1,
AdMob.AD_POSITION.TOP_CENTER 	= 2,
AdMob.AD_POSITION.TOP_RIGHT 	= 3,
AdMob.AD_POSITION.LEFT 			= 4,
AdMob.AD_POSITION.CENTER 		= 5,
AdMob.AD_POSITION.RIGHT 		= 6,
AdMob.AD_POSITION.BOTTOM_LEFT 	= 7,
AdMob.AD_POSITION.BOTTOM_CENTER	= 8,
AdMob.AD_POSITION.BOTTOM_RIGHT 	= 9,
AdMob.AD_POSITION.POS_XY 		= 10, // ����ָ��λ�� X �� Y, �μ� 'x' and 'y'
```
- **x**, *integer*, x����. �� *overlap*:true �� *position*:AdMob.AD_POSITION.POS_XY ��ʱ����Ч. Ĭ��ֵ: 0
- **y**, *integer*, y����. �� *overlap*:true �� *position*:AdMob.AD_POSITION.POS_XY ��ʱ����Ч. Ĭ��ֵ: 0
- **isTesting**, *boolean*, ���ڲ��ԣ�������Ϊ true ��ʱ�򣬿��Խ��ղ��Թ�棬������ʱ�����������Ϊ false�����򲻼������档
- **autoShow**, *boolean*, �����׼������ʱ�Զ���ʾ��������Ҫ���� showBanner ���� showInterstitial
- **orientationRenew**, *boolean*, ����Ļ�������仯ʱ��ǿ�����ٺ����´����������һ������������á�
- **offsetTopBar**, *boolean*, ƫ�ƹ������WebView�����ⱻ״̬���ڵ� (iOS7+)
- **bgColor**, *string*, ���ø����ڵı���ɫ, ����ֵ��'black', 'white'�ȵ�, ����RGB��ʽ '#RRGGBB'
- **adExtras**, *json object*, Ϊ�����ʾ���ö����ɫ�ʷ��.
```javascript
{
	color_bg: 'AAAAFF',
	color_bg_top: 'FFFFFF',
	color_border: 'FFFFFF',
	color_link: '000080',
	color_text: '808080',
	color_url: '008000'
}
```

����:
```javascript
var defaultOptions = {
    license: 'username@gmail.com/xxxxxxxxxxxxxxx',
	bannerId: admobid.banner,
	interstitialId: admobid.interstitial,
	adSize: 'SMART_BANNER',
	width: 360, // valid when set adSize 'CUSTOM'
	height: 90, // valid when set adSize 'CUSTOM'
	position: AdMob.AD_POSITION.BOTTOM_CENTER,
	x: 0,		// valid when set position to POS_XY
	y: 0,		// valid when set position to POS_XY
	isTesting: true,
	autoShow: true
};
AdMob.setOptions( defaultOptions );
```

### AdMob.createBanner(adId/options, success, fail) ###

> **��;**: ���������. ����������Դ������ID�ַ�����Ҳ���Դ���Json�����԰��������ѡ�

**����**
- **adId**, *string*, ������� ID.
- **options**, *json object*, ���Ը�������ѡ��μ� **AdMob.setOptions**
- **success**, *function*, �ɹ�֮��Ļص�����������Ϊ null ���� ȱʧ.
- **fail**, *function*, ʧ��֮��Ļص�����������Ϊ null ���� ȱʧ.

���� **options** �����ж����ѡ�
- **adId**, *string*, ������� ID.
- **success**, *function*, �ɹ�֮��Ļص�����.
- **error**, *function*, ʧ��֮��Ļص�����.

����:
```javascript
// ���������� ID����������Ĭ��ֵ
AdMob.createBanner( admobid.banner );

// ��������Ĳ���
AdMob.createBanner({
	adId: admobid.banner,
	position: AdMob.AD_POSITION.BOTTOM_CENTER,
	autoShow: true,
	success: function(){
	},
	error: function(){
		alert('failed to create banner');
	}
});
```
## AdMob.showBanner(position) ##

> **��;**: ��ָ����λ����ʾ�����. Ҳ���������ƶ�����������������ٺ����´����������

����:
- **position**, *integer*, �μ� **AdMob.setOptions()**

## AdMob.showBannerAtXY(x, y) ##

> **��;**: ���ƶ�������λ�� (x,y) ��ʾ�����. 

����:
- **x**, *integer*, ����. ����Ļ��߼����ƫ����.
- **y**, *integer*, ����. ����Ļ���˼����ƫ����.

### AdMob.hideBanner() ###

> **��;**: ���ع��������ʱ����Ļ���Ƴ�����û�����٣��Ժ󻹿��Լ�����ʾ. 

### AdMob.removeBanner() ###

> **��;**: ���ٹ������������ʾʱ���ã������û��Ѿ����ѣ�ȥ����档 

## AdMob.prepareInterstitial(adId/options, success, fail) ##

> **��;**: ׼��ȫ�������Դ�����ں�����ʾ��

����:
- **adId**, *string*, ȫ�����Ĺ��ID.
- **options**, *string*, �μ� **AdMob.setOptions()*
- **success**, *function*, �ɹ�֮��Ļص�����������Ϊ null ���� ȱʧ.
- **fail**, *function*, ʧ��֮��Ļص�����������Ϊ null ���� ȱʧ.

���� **options** �����ж����ѡ�
- **adId**, *string*, ������� ID.
- **success**, *function*, �ɹ�֮��Ļص�����.
- **error**, *function*, ʧ��֮��Ļص�����.

> ������ʾ: ͨ��ȫ�������Ҫ�϶��ͼƬ��Դ�ȹ�����Զ࣬�������Ҳ���Զ�һ�㣬ͨ����Ҫһ���ʱ����׼���������û�����ȴ����������á�

## AdMob.showInterstitial() ##

> **��;**: ��ȫ�����׼������ʱ����ʾ���û�����

����:
```javascript
// ׼���������Զ���ʾ����Լ��Ҫ0.5-1��
AdMob.prepareInterstitial({
	adId: admobid.interstitial,
	autoShow: true
});

// ����Ϸ�ؿ���ʼ��ʱ��׼�������Դ
AdMob.prepareInterstitial({
	adId: admobid.interstitial,
	autoShow: false
});
// ����Ϸ�ؿ�������ʱ�򣬼�鲢����ʾ���
if(isready) AdMob.showInterstitial();
```

## �¼� ##

�������е��¼���������������������
* data.adNetwork, ������������, ���� 'AdMob', 'Flurry', 'iAd', etc.
* data.adType, 'banner' ���� 'interstitial'
* data.adEvent, �¼�������
������Щ������ֵ����������ص��жϡ�

'onAdFailLoad'
> ���ӹ����������ع����Դʧ�ܵ�ʱ�򴥷�. 
```javascript
document.addEventListener('onAdFailLoad',function(data){
	console.log( data.error + ',' + data.reason );
	if(data.adType == 'banner') AdMob.hideBanner();
	else if(data.adType == 'interstitial') interstitialIsReady = false;
});
```

'onAdLoaded'
> �������Դ�ӷ������ɹ�����֮�󴥷�.
```javascript
document.addEventListener('onAdLoaded',function(data){
	AdMob.showBanner();
});
AdMob.createBanner({
	adId: admobid.banner,
	autoShow: false
});
```

'onAdPresent'
> �����ɹ���ʾ������ʱ�򴥷�.

'onAdLeaveApp'
> ���û��������ʱ�򣬼�����ת���������ָ�����վʱ������Ҳ������Լ����û�����˶��ٴΡ�

'onAdDismiss'
> ����汻�رգ��ص�Ӧ�û�����Ϸ��ʱ�򴥷���

## ����ʹ�� Android Proguard ������ �����Թȸ裩##

Ϊ�˱������Ҫ��������������Ҫ�� <project_directory>/platform/android/proguard-project.txt �ļ��м�����������:

```
-keep class * extends java.util.ListResourceBundle {
    protected Object[][] getContents();
}

-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
    public static final *** NULL;
}

-keepnames @com.google.android.gms.common.annotation.KeepName class *
-keepclassmembernames class * {
    @com.google.android.gms.common.annotation.KeepName *;
}

-keepnames class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

-keep public class com.google.cordova.admob.**

```
