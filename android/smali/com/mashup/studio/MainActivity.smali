.class public Lcom/mashup/studio/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"

.field public web:Landroid/webkit/WebView;
.field public fileCb:Landroid/webkit/ValueCallback;
.field public pending:[B

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 8

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/mashup/studio/MainActivity;->getWindow()Landroid/view/Window;
    move-result-object v0
    const/16 v1, 0x80
    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/mashup/studio/MainActivity;->web:Landroid/webkit/WebView;

    const v1, -0xebedea
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    const/4 v3, 0x0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    const/16 v3, 0x64
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setTextZoom(I)V

    new-instance v1, Lcom/mashup/studio/Chrome;
    invoke-direct {v1, p0}, Lcom/mashup/studio/Chrome;-><init>(Lcom/mashup/studio/MainActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    new-instance v1, Lcom/mashup/studio/Bridge;
    invoke-direct {v1, p0}, Lcom/mashup/studio/Bridge;-><init>(Lcom/mashup/studio/MainActivity;)V
    const-string v2, "AndroidBridge"
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/mashup/studio/MainActivity;->setContentView(Landroid/view/View;)V

    invoke-virtual {p0}, Lcom/mashup/studio/MainActivity;->readAsset()Ljava/lang/String;
    move-result-object v4

    move-object v2, v0
    const-string v3, "https://appassets.androidplatform.net/"
    const-string v5, "text/html"
    const-string v6, "utf-8"
    const/4 v7, 0x0
    invoke-virtual/range {v2 .. v7}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public readAsset()Ljava/lang/String;
    .locals 5

    :try_start_0
    invoke-virtual {p0}, Lcom/mashup/studio/MainActivity;->getAssets()Landroid/content/res/AssetManager;
    move-result-object v0
    const-string v1, "index.html"
    invoke-virtual {v0, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    move-result-object v0

    new-instance v1, Ljava/io/ByteArrayOutputStream;
    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v2, 0x4000
    new-array v2, v2, [B

    :loop_0
    invoke-virtual {v0, v2}, Ljava/io/InputStream;->read([B)I
    move-result v3
    if-ltz v3, :done_0
    const/4 v4, 0x0
    invoke-virtual {v1, v2, v4, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    goto :loop_0

    :done_0
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    const-string v2, "UTF-8"
    invoke-virtual {v1, v2}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0
    const-string v0, "<html><body style=\"background:#141216;color:#eee;font-family:sans-serif\">Не вдалося завантажити інтерфейс.</body></html>"
    return-object v0
.end method

.method public notifySaved(Z)V
    .locals 3

    iget-object v0, p0, Lcom/mashup/studio/MainActivity;->web:Landroid/webkit/WebView;
    if-eqz v0, :ret_0
    if-eqz p1, :fail_0
    const-string v1, "window.__androidSaved&&window.__androidSaved(true)"
    goto :go_0
    :fail_0
    const-string v1, "window.__androidSaved&&window.__androidSaved(false)"
    :go_0
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    :ret_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 4

    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    const/4 v0, 0x1
    if-ne p1, v0, :not_file

    iget-object v1, p0, Lcom/mashup/studio/MainActivity;->fileCb:Landroid/webkit/ValueCallback;
    if-eqz v1, :ret_file
    invoke-static {p2, p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->parseResult(ILandroid/content/Intent;)[Landroid/net/Uri;
    move-result-object v2
    const/4 v3, 0x0
    iput-object v3, p0, Lcom/mashup/studio/MainActivity;->fileCb:Landroid/webkit/ValueCallback;
    invoke-interface {v1, v2}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    :ret_file
    return-void

    :not_file
    const/4 v0, 0x2
    if-ne p1, v0, :ret_other

    const/4 v0, 0x0
    const/4 v1, -0x1
    if-ne p2, v1, :finish_save
    if-eqz p3, :finish_save

    :try_start_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v1
    invoke-virtual {p0}, Lcom/mashup/studio/MainActivity;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v2
    invoke-virtual {v2, v1}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;
    move-result-object v2
    iget-object v3, p0, Lcom/mashup/studio/MainActivity;->pending:[B
    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    const/4 v0, 0x1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    :finish_save
    const/4 v1, 0x0
    iput-object v1, p0, Lcom/mashup/studio/MainActivity;->pending:[B
    invoke-virtual {p0, v0}, Lcom/mashup/studio/MainActivity;->notifySaved(Z)V

    :ret_other
    return-void

    :catch_1
    move-exception v1
    const/4 v0, 0x0
    goto :finish_save
.end method
