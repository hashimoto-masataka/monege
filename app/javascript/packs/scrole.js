$('#wrapper').multiscroll({
	sectionsColor: ['#0f7fa7', '#504237', '#504237','#504237', '#504237', '#504237'],//セクションごとの背景色設定
	anchors: ['area1', 'area2', 'area3','area4','area5','area6'],//セクションとリンクするページ内アンカーになる名前
	menu: '#menu',//上部ナビゲーションのメニュー設定
	navigation: true,//右のナビゲーション出現、非表示は false
	//navigationTooltips:['Area1', 'Area2', 'Area3','Area4','Area5'],//右のナビゲーション現在地時に入るテキスト
	//loopTop: true,//最初のセクションを上にスクロールして最後のセクションまでスクロールするかどうかを定義します。
	loopBottom: true,//最後のセクションを下にスクロールして最初のセクションまでスクロールするかどうかを定義します。
    //※以下は今回のプラグインの組み合わせのみで使用。ページの途中でリロードしてもトップのタイピング出現
    afterLoad: function(anchorLink, index){
		if(index == 1){
			TextTypingAnime();
		}	
	}

    
});
