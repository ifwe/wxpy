import wx
import wx.tests
import py.test

def setup_module(module):
    wx.tests.setup()

def test_skip():
    e = wx.CommandEvent()

    e.Skip(True)    
    assert e.Skipped and e.GetSkipped()
    
    e.Skip(False)
    assert not e.Skipped and not e.GetSkipped()
    
    e.SetId(42)
    assert e.Id == e.GetId() == 42

def no_test_bind():
    f = wx.Frame(None)
    b = wx.Button(f, -1, 'Button test')
    
    flags = dict(frame=False, button=False)
    
    def on_frame():
        flags['frame'] = True
    
    def on_button():
        flags['button'] = True
    
    b.Bind(wx.EVT_BUTTON, on_button)
    f.Bind(wx.EVT_BUTTON, on_frame)
    
    b.Push()
    
    assert flags['button'] == True
    
    f.Destroy()
