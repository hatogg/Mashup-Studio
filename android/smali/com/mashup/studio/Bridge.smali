.class public Lcom/mashup/studio/Bridge;
.super Ljava/lang/Object;
.source "Bridge.java"

.field public act:Lcom/mashup/studio/MainActivity;
.field public buf:Ljava/io/ByteArrayOutputStream;

.method public constructor <init>(Lcom/mashup/studio/MainActivity;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/mashup/studio/Bridge;->act:Lcom/mashup/studio/MainActivity;
    return-void
.end method

.method public begin()V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Ljava/io/ByteArrayOutputStream;
    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V
    iput-object v0, p0, Lcom/mashup/studio/Bridge;->buf:Ljava/io/ByteArrayOutputStream;
    return-void
.end method

.method public chunk(Ljava/lang/String;)V
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    const/4 v0, 0x0
    invoke-static {p1, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B
    move-result-object v1
    iget-object v2, p0, Lcom/mashup/studio/Bridge;->buf:Ljava/io/ByteArrayOutputStream;
    array-length v3, v1
    invoke-virtual {v2, v1, v0, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    return-void
.end method

.method public finish(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/mashup/studio/Bridge;->act:Lcom/mashup/studio/MainActivity;
    iget-object v1, p0, Lcom/mashup/studio/Bridge;->buf:Ljava/io/ByteArrayOutputStream;
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    move-result-object v1
    iput-object v1, v0, Lcom/mashup/studio/MainActivity;->pending:[B
    const/4 v1, 0x0
    iput-object v1, p0, Lcom/mashup/studio/Bridge;->buf:Ljava/io/ByteArrayOutputStream;

    new-instance v1, Lcom/mashup/studio/SaveRunner;
    invoke-direct {v1, v0, p1, p2}, Lcom/mashup/studio/SaveRunner;-><init>(Lcom/mashup/studio/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Lcom/mashup/studio/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void
.end method

.method public isApp()Z
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    const/4 v0, 0x1
    return v0
.end method
