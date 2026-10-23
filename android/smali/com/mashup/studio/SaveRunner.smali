.class public Lcom/mashup/studio/SaveRunner;
.super Ljava/lang/Object;
.source "SaveRunner.java"

# interfaces
.implements Ljava/lang/Runnable;

.field public act:Lcom/mashup/studio/MainActivity;
.field public name:Ljava/lang/String;
.field public mime:Ljava/lang/String;

.method public constructor <init>(Lcom/mashup/studio/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/mashup/studio/SaveRunner;->act:Lcom/mashup/studio/MainActivity;
    iput-object p2, p0, Lcom/mashup/studio/SaveRunner;->name:Ljava/lang/String;
    iput-object p3, p0, Lcom/mashup/studio/SaveRunner;->mime:Ljava/lang/String;
    return-void
.end method

.method public run()V
    .locals 4

    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.intent.action.CREATE_DOCUMENT"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v1, "android.intent.category.OPENABLE"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    iget-object v1, p0, Lcom/mashup/studio/SaveRunner;->mime:Ljava/lang/String;
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "android.intent.extra.TITLE"
    iget-object v2, p0, Lcom/mashup/studio/SaveRunner;->name:Ljava/lang/String;
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/mashup/studio/SaveRunner;->act:Lcom/mashup/studio/MainActivity;

    :try_start_0
    const/4 v2, 0x2
    invoke-virtual {v1, v0, v2}, Lcom/mashup/studio/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v2
    const/4 v3, 0x0
    invoke-virtual {v1, v3}, Lcom/mashup/studio/MainActivity;->notifySaved(Z)V
    return-void
.end method
