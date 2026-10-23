from PIL import Image, ImageDraw, ImageChops
import os
BG=(28,24,34,255); A=(255,162,74); B=(106,206,255)
def discs(size, scale_content):
    S=size*4
    img=Image.new('RGBA',(S,S),(0,0,0,0))
    r=int(S*scale_content*0.26)
    cy=S//2; off=int(r*0.62)
    la=Image.new('L',(S,S),0); ImageDraw.Draw(la).ellipse([S//2-off-r,cy-r,S//2-off+r,cy+r],fill=255)
    lb=Image.new('L',(S,S),0); ImageDraw.Draw(lb).ellipse([S//2+off-r,cy-r,S//2+off+r,cy+r],fill=255)
    inter=ImageChops.multiply(la,lb)
    img.paste(Image.new('RGBA',(S,S),A+(255,)),(0,0),la)
    img.paste(Image.new('RGBA',(S,S),B+(255,)),(0,0),lb)
    img.paste(Image.new('RGBA',(S,S),(250,244,236,255)),(0,0),inter)
    # groove rings
    d=ImageDraw.Draw(img)
    for k,(cx,col) in enumerate([(S//2-off,(120,62,20,110)),(S//2+off,(20,70,110,110))]):
        for f in (0.72,0.5):
            rr=int(r*f); d.ellipse([cx-rr,cy-rr,cx+rr,cy+rr],outline=col,width=max(2,S//180))
        rr=int(r*0.12); d.ellipse([cx-rr,cy-rr,cx+rr,cy+rr],fill=(28,24,34,255))
    return img.resize((size,size),Image.LANCZOS)
dens={'mdpi':1,'hdpi':1.5,'xhdpi':2,'xxhdpi':3,'xxxhdpi':4}
for name,f in dens.items():
    os.makedirs(f'android/res/mipmap-{name}',exist_ok=True)
    fg=discs(int(108*f),0.62*1.0)
    fg.save(f'android/res/mipmap-{name}/ic_fg.png')
    s=int(48*f); S=s*4
    base=Image.new('RGBA',(S,S),(0,0,0,0))
    ImageDraw.Draw(base).rounded_rectangle([0,0,S-1,S-1],radius=int(S*0.22),fill=BG)
    base=base.resize((s,s),Image.LANCZOS)
    d=discs(s,0.95)
    base.alpha_composite(d)
    base.save(f'android/res/mipmap-{name}/ic_launcher.png')
discs(512,0.95).save('docs/icon.png')
print('done')
