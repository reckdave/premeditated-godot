using Godot;
using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

public partial class WallpaperHandler : Node2D
{
	public static string userPath = "";

	public enum UAction
	{
		SPI_SETDESKWALLPAPER = 20,
		SPI_GETDESKWALLPAPER = 115
	}

	[DllImport("user32.dll")]
	public static extern int SystemParametersInfo(UAction uAction, int uParam, StringBuilder lpvParam, int fuWinIni);

	public static void W1() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/1.jpg");
	public static void W2() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/2.jpg");
	public static void W3() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/3.jpg");
	public static void W4() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/4.jpg");
	public static void W5() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/5.jpg");
	public static void W6() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/6.jpg");
	public static void W7() => setBackground(OS.GetExecutablePath().GetBaseDir() + "/Wallpapers/7.jpg");

	public override void _Ready()
	{
		userPath = getBackground();
		
	}

	public static void Wuser()
	{
		setBackground(userPath);
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
		string userFilePath = fileName;
		if (System.IO.File.Exists(userFilePath))
		{
			StringBuilder s = new StringBuilder(userFilePath);
			result = SystemParametersInfo(UAction.SPI_SETDESKWALLPAPER, 0, s, 2);
		}
		return result;
	}
	
}
