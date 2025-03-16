using Godot;
using System;
using System.Runtime.InteropServices;
using System.Text;

public partial class WallpaperHandler : Node2D
{
	public enum UAction
	{
		SPI_SETDESKWALLPAPER = 20,
		SPI_GETDESKWALLPAPER = 115
	}
	
	[DllImport("user32.dll")]
	public static extern int SystemParametersInfo(UAction uAction, int uParam, StringBuilder lpvParam, int fuWinIni);
	
	public static void W1()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/1.png");
	}
	public static void W2()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/2.png");
	}
	public static void W3()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/3.png");
	}
	public static void W4()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/4.png");
	}
	public static void W5()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/5.png");
	}
	public static void W6()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/6.png");
	}
	public static void W7()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/7.png");
	}
	public static void Wuser()
	{
		setBackground(OS.GetUserDataDir() + "/Wallpapers/user.png");
	}
	
	
	public static string getBackground()
	{
		StringBuilder s = new StringBuilder(300);
		SystemParametersInfo(UAction.SPI_GETDESKWALLPAPER, 300, s, 0);
		return s.ToString();
	}
	
	public static int setBackground(string fileName)
	{
		int result = 0;
		if (System.IO.File.Exists(fileName))
		{
			StringBuilder s = new StringBuilder(fileName);
			result = SystemParametersInfo(UAction.SPI_SETDESKWALLPAPER, 0, s, 2);
		}
		return result;
	}
	
}
