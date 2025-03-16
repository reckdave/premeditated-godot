using Godot;
using System;
using Microsoft.Toolkit.Uwp.Notifications;

public partial class NotificationHandler : Node2D
{
	
	public override void _Ready()
	{
		//CreateNotifi("Hello","Im here.");
	}
	
	public void CreateNotifi(string title, string message)
	{
		if (OS.GetName() == "Windows")
		{
			new ToastContentBuilder()
				.AddText(title)
				.AddText(message)
				.Show();
		}
	}
}
