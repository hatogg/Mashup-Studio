.class public Lcom/mashup/studio/Chrome;
.super Landroid/webkit/WebChromeClient;
.source "Chrome.java"

.field public act:Lcom/mashup/studio/MainActivity;

.method public constructor <init>(Lcom/mashup/studio/MainActivity;)V
    .locals 0
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V
    iput-object p1, p0, Lcom/mashup/studio/Chrome;->act:Lcom/mashup/studio/MainActivity;
    return-void
.end method

.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .locals 4

    iget-object v0, p0, Lcom/mashup/studio/Chrome;->act:Lcom/mashup/studio/MainActivity;
    iget-object v1, v0, Lcom/mashup/studio/MainActivity;->fileCb:Landroid/webkit/ValueCallback;
    if-eqz v1, :nocb_0
    const/4 v2, 0x0
    invoke-interface {v1, v2}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    :nocb_0
    iput-object p2, v0, Lcom/mashup/studio/MainActivity;->fileCb:Landroid/webkit/ValueCallback;

    :try_start_0
    invoke-virtual {p3}, Landroid/webkit/WebChromeClient$FileChooserParams;->createIntent()Landroid/content/Intent;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v0, v1, v2}, Lcom/mashup/studio/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, 0x1
    return v3

    :catch_0
    move-exception v1
    const/4 v2, 0x0
    iput-object v2, v0, Lcom/mashup/studio/MainActivity;->fileCb:Landroid/webkit/ValueCallback;
    const/4 v3, 0x0
    return v3
.end method
