using Godot;
using System;
using System.Windows;
using Microsoft.Toolkit.Uwp.Notifications;

public partial class NotificationHandler : Node2D
{
	public override void _Ready()
	{
		//CreateNotifi("Hello","Im here.");
	}
	
	public void CreateNotifi(string title, string message)
	{
		new ToastContentBuilder()
			.AddText(title)
			.AddText(message)
			.Show();
	}
}
