SBTranslator
===================================

This library allows you to build your in-app setting page with only 3 lines of code. 
It will read from your Settings.bundle and construct everything else automatically. 



###How to use: (three simple steps)

######Import:
<pre><code>#import SBTranslatorViewController.h</code></pre>
Note: You need to include SBTranslatorViewController.h in your bridging header if you are using swift

######Initialize:
<pre><code>SBTranslatorViewController *settingViewController = [[SBTranslatorViewController alloc]init];</code></pre>

######Present:
<pre><code>[self.navigationController pushViewController:settingViewController animated:YES];</code></pre>


###done!