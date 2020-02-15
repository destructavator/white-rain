Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

1 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Beginners Help
Change font size
Print view
FAQ
Register
Login

(SDK v1.7) Animated mesh moving out-of-sync w/Parent JointNd
Post a reply

7 posts • Page 1 of 1

(SDK v1.7) Animated mesh moving out-of-sync w/Parent JointNd
by Destructavator » Sat Feb 06, 2010 9:29 pm
Hi, I'm working on a small GPL project, currently in an "infancy" stage, which I'm having an issue with, as
I'm also learning C++ at the same time. After looking hard through the forum and API I can't figure out why
this one issue occurs:
I have a character built out of several meshes, exported with skeletons from Blender in B3D format, and I've
set the torso/upper body mesh as a parent to the legs/lower body mesh, which works fine when the character
walks around, but when the character steps off something and falls the upper body lags behind and won't fall
as fast, resulting in the upper and lower body meshes becoming separated.
The collision animator was applied to the lower body half, and the upper half is connected as a child to the
joint node in the lower half's skeleton.
I'm not sure what I'm doing wrong - I don't know if this is from a bug in the SDK, but I strongly feel that
most likely it is from my own inexperience or outright stupidity with C++.

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

2 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

Here are several screen shots that show what happens:
Image
Image
Image
Here's a link to the source code files:
http://www.destructavator.com/92dl/src.zip
I would post just the relevant parts causing the issue if I knew where it was, which I don't.
BTW, since I'm new here, first post, allow me to explain that I've been playing around with Irrlicht since 1.4
came out, and usually I can find the answer I need in the forum or elsewhere on the net - This is the first time
I couldn't find the answer I'm looking for.
Allow me to also explain that I'm learning C++ on my own from books and Internet sources - I am not a
student in any school, and I live in a part of the world where school does not come free and is in fact
outrageously expensive. I have enough trouble keeping my small one-bedroom apartment afloat (Yes, I'm on
my own).
Finally, for those that might recognize my screen name, yes, I'm the same guy from over at the UFO: Alien
Invasion project on Sourceforge.
I'd appreciate any help and advice with this - I've spent quite a bit of time putting things in different places
and changing this and that (as can be seen in commented-out lines of code).
Thanks in advance.
P.S. Yes, I know this character has no hands, I haven't added those models yet. Right now I'm just doing tests
before I add and redo some things here and there...
Edit: Sorry for the huge screen shots, I'm not used to this forum and assumed the pictures would be scaled
down to thumbnails, sorry!
Edit(2): OK, I scaled the pictures down a bit - I hope that makes this post easier to read.
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Sat Feb 06, 2010 10:04 pm
I thought I'd mention, I've been playing around a lot with this function in "player.cpp", I don't know if
something here is the problem:

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

3 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

Code: Select all
void PlayerC::upDateView()
{
plyr->updateAbsolutePosition();
if(gamePaused==false) plyr->animateJoints(true);
if(gamePaused==false) plyrT->animateJoints(true);
// plyrNode->updateAbsolutePositionOfAllChildren();
// plyr->updateAbsolutePosition();
// plyrT->setPosition(vector3df(0.f, 0.f, 0.f));
core::vector3df tLoc=camFocus->getAbsolutePosition();
tLoc.Y += (2.f * globalScale);
if(gamePaused==false) camera->setTarget(tLoc);
// plyrT->updateAbsolutePosition();
}

The function gets called before the beginScene() does:
Code: Select all
while(device->run())
{
// gameAudio->update();
// driver->beginScene(true, true, SColor(255,0,0,0));
gMSTimer->tick();
gTimer->UpdateGameTiming(masterTiming);
Demo->updateDemo();
driver->beginScene(true, true, SColor(255,0,0,0));
smgr->drawAll();
guienv->drawAll();
if(recv.IsKeyDown(KMap[6].KeyCode))
{
gameState=0;
break;
}
driver->endScene();
}

The "Demo" section calls it when it updates stuff.
Code: Select all
void MissionDemo::updateDemo()
{
// PC->upDateView();
PCLoc = PC->getPosition();

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

4 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

PCRot = PC->getRotation();
if((PC->GetPauseStatus()==false) && (device->isWindowFocused()==true)) mousePos =
MControl->MRead();
if(recv.IsKeyDown(KMap[4].KeyCode)) this->PauseGame();
if((recv.IsKeyDown(KMap[5].KeyCode)) && (device->isWindowFocused()==true))
this->UnPauseGame();
if(device->isWindowFocused()==false) this->PauseGame();
PC->setAngle(mousePos);
isMoving=false;
if(recv.IsKeyDown(KMap[2].KeyCode))
{
isMoving=true;
moveHeading=270;
}
if(recv.IsKeyDown(KMap[3].KeyCode))
{
isMoving=true;
moveHeading=90;
}
if((recv.IsKeyDown(KMap[2].KeyCode)) && (recv.IsKeyDown(KMap[3].KeyCode)))
{
isMoving=false;
moveHeading=0;
}
if(recv.IsKeyDown(KMap[1].KeyCode))
{
isMoving=true;
moveHeading=180;
if(recv.IsKeyDown(KMap[2].KeyCode))
{
moveHeading=225;
}
if(recv.IsKeyDown(KMap[3].KeyCode))
{
moveHeading=135;
}
if((recv.IsKeyDown(KMap[2].KeyCode)) && (recv.IsKeyDown(KMap[3].KeyCode)))
{
moveHeading=180;
}
}
if(recv.IsKeyDown(KMap[0].KeyCode))
{
isMoving=true;
moveHeading=0;
if(recv.IsKeyDown(KMap[2].KeyCode))
{
moveHeading=315;

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

5 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

}
if(recv.IsKeyDown(KMap[3].KeyCode))
{
moveHeading=45;
}
if((recv.IsKeyDown(KMap[2].KeyCode)) && (recv.IsKeyDown(KMap[3].KeyCode)))
{
moveHeading=0;
}
}
if
if
//
if
{

(PC->GetPauseStatus() == true) isMoving=false;
(gameIsPaused==true) isMoving=false;
gTimer->UpdateGameTiming(masterTiming);
(isMoving==true)
PCLoc=gTimer->CalcMove(PCLoc, PCRot, 14.f, moveHeading);
PC->setAnim(moveHeading, 0, 0, 1, 0);
PC->setPosition(PCLoc);

}
else
{
if (gameIsPaused==false) PC->setAnim(0, 0, 0, 0, 0);
}
PC->upDateView();
if(recv.IsKeyDown(KMap[7].KeyCode))
{
ScreenCap.TakeScreenShot();
}
}

It's right near the bottom, right before the code for taking screen shots.
I also tried changing things where the meshes are initially set up, the "plyrT" mesh is the top half, the "plyr"
mesh is the bottom.
Code: Select all
PlayerC::PlayerC(bool lighting, float PosX, float PosY, float PosZ)
{
// plyr = smgr->addEmptySceneNode();
marc = smgr->getMesh("gamedata/characters/marc/Marc_Legs.b3d");
plyr = smgr->addAnimatedMeshSceneNode(marc);
// plyr->setParent(plyr);
marcT = smgr->getMesh("gamedata/characters/marc/Marc_Torso.b3d");
plyrT = smgr->addAnimatedMeshSceneNode(marcT);
// marcTex = driver->getTexture("gamedata/characters/marc/mchar1d.jpg");
// plyr->setMaterialTexture(0, marcTex);
plyr->setMaterialFlag(EMF_LIGHTING, lighting);
plyrT->setMaterialFlag(EMF_LIGHTING, lighting);

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

6 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

plyr->setPosition(core::vector3df(PosX, PosY, PosZ));
plyrNode = plyr->getJointNode("torso");
plyrT->setParent(plyrNode);
// plyr->animateJoints(true);
plyr->setFrameLoop(1, 3);
plyr->setAnimationSpeed(8);
plyrT->setFrameLoop(1, 1);
plyrT->setAnimationSpeed(8);
headMesh = smgr->getMesh("gamedata/characters/marc/head.b3d");
head = smgr->addAnimatedMeshSceneNode( headMesh );
headTex = driver->getTexture("gamedata/characters/marc/head01_3.jpg");
head->setMaterialTexture(0, headTex);
head->setMaterialFlag(EMF_LIGHTING, lighting);
head->setParent(plyrT->getJointNode("head"));
head->setRotation(core::vector3df(0.f, 180.f, 0.f));
plyr->setRotation(core::vector3df(0.f, 0.f, 0.f));
camFocus=smgr->addEmptySceneNode(0);
camFocus->setParent(head);
camFocus->setPosition(core::vector3df(0.f, 0.f, 0.f));
camera->setParent(camFocus);
camera->setPosition(core::vector3df(0.f, 5.f, -20.f));
camera->setTarget(core::vector3df(PosX, PosY+20.f, PosZ));
gamePaused=false;
newAnim[0]=1;
newAnim[1]=3;
oldAnim[0]=1;
oldAnim[1]=3;
animSpeed=5.f;
retAnimFrames=vector2di(1, 3);
plyr->setCurrentFrame(1);
plyr->setAnimationSpeed(1);
plyr->setTransitionTime(1.f/animSpeed);
plyrShadow = plyr->addShadowVolumeSceneNode(0, -1, false);
plyrTShadow = plyrT->addShadowVolumeSceneNode(0, -1, false);
headShadow = head->addShadowVolumeSceneNode(headMesh, -1, false);
isJumping=false;
fallingState=0;
isFalling=false;
// fallingSpeed=0.f;
// movePlyr = 0;
}

...Unless its an issue with the animator:

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

7 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

Code: Select all
void PlayerC::AddColl()
{
ISceneNodeAnimator* anim = smgr->createCollisionResponseAnimator(
worldColl, plyr, core::vector3df(2.5f, 10.f, 2.5f),
core::vector3df(0.f , -5.f, 0.f), core::vector3df(0,-10,0));
plyr->addAnimator(anim);
anim->drop();
}

User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by hybrid » Sat Feb 06, 2010 11:48 pm
The problem will be an issue with the update of positions. Most movement happens in drawAll(), while your
code takes the results of the previous drawAll(). I didn't follow all your code fragments, but I guess you
should condense your movement stuff and joint updates into a new animator. Or you should move the
animator code into your manual update code. Otherwise, slight offsets will be unavoidable. However, having
a high framerate should reduce this effect as well.
hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top
by Destructavator » Sat Feb 06, 2010 11:53 pm
OK, thanks, I'll try that - right now I do have all the movement and animation stuff split up quite a bit.
Thanks for the rather fast reply.
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

8 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

by B@z » Sun Feb 07, 2010 7:30 am
im surprised that this bug still exists.
we found this around irrlicht 1.4? or maybe older version, and still wasnt fixed?
anyway, a workaround for that:
call this in every frame (i usually call it in my Control funciton)
Code: Select all
void UpdateAbsoluteTransformationAndChildren(ISceneNode *Node)
{
Node->updateAbsolutePosition();
core::list<ISceneNode*>::ConstIterator it = Node->getChildren().begin();
for (; it != Node->getChildren().end(); ++it)
{
UpdateAbsoluteTransformationAndChildren((*it));
}
}

use this only on your parent joint, and it will update every children of it
Image
Image
B@z
Posts: 876
Joined: Thu Jan 31, 2008 5:05 pm
Location: Hungary
Top
by tecan » Sun Feb 07, 2010 8:22 pm
by the way there arnt any models included with the src.zip

tecan
Posts: 386
Joined: Fri Jun 06, 2008 12:50 pm
Location: Edmonton, Alberta, Canada
Website
ICQ
Top

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

9 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

by Destructavator » Mon Feb 08, 2010 7:31 pm
B@z wrote:im surprised that this bug still exists.
we found this around irrlicht 1.4? or maybe older version, and still wasnt fixed?
anyway, a workaround for that:
call this in every frame (i usually call it in my Control funciton)
Code: Select all
void UpdateAbsoluteTransformationAndChildren(ISceneNode *Node)
{
Node->updateAbsolutePosition();
core::list<ISceneNode*>::ConstIterator it =
Node->getChildren().begin();
for (; it != Node->getChildren().end(); ++it)
{
UpdateAbsoluteTransformationAndChildren((*it));
}
}

use this only on your parent joint, and it will update every children of it

Thanks, I'll try this out as well.
@tecan (and anyone else interested):
Try this package if you want to play around with it:
http://www.destructavator.com/92dl/MarcHawk11.zip
There's an already-compiled EXE in there, done with CodeBlocks IDE using MS Visual Studio Express 2008
compiler, although I'd imagine other compilers should work too.
The WSAD keys move around, the mouse controls angle and direction (sort of like a Max Payne-style 3rd
person camera), the PAUSE key pauses the game and the BACKSPACE unpauses. ESC exits the program.
BTW, This whole thing is going to be GPL, so if anyone at a beginner-level like myself needs examples for
some basic things that they see in this small app that they would like to do themselves, I don't mind if people
copy-paste a few parts and such for their own personal or GPL projects. I don't write very good code yet, but
already this app reads and writes an XML config file on startup, has a basic 3rd-person camera, and combines
multiple map tiles together which are read for collision all at once.
Of course, once someone gets better at C++ they will probably outgrow code anything like what's in this app,
I'm not going to pretend that this code was written very well...
User avatar
Destructavator
9/6/2019, 3:58 PM

Irrlicht Engine • View topic - (SDK v1.7) Animated mesh moving out-of...

10 of 10

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=37225

Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
Display posts from previous:

Sort by

Post a reply
7 posts • Page 1 of 1
Return to Beginners Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:58 PM

Irrlicht Engine • View topic - Custom scene node class?

1 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49950

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Advanced Help
Change font size
Print view
FAQ
Register
Login

Custom scene node class?
Post a reply

10 posts • Page 1 of 1

Custom scene node class?
by danielmccarthy » Tue Jun 10, 2014 11:29 pm
I am trying to extend the IMeshSceneNode class but their are virtual functions such as setMesh and stuff.
I tried calling the base class from my class within the setMesh method so it would create the mesh but it had
an undefined reference.
Can anyone tell me how to extend the IMeshSceneNode successfully.
The thing is I made a Map class which extends this and I want to be able to use all the methods I can use in
the IMeshSceneNode as well as custom ones which I will make such as addObject(x, y, z).
Many Thanks,
Dan
danielmccarthy
Posts: 51

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - Custom scene node class?

2 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49950

Joined: Fri May 30, 2014 12:55 am
Top

Re: Custom scene node class?
by Seven » Wed Jun 11, 2014 12:29 am
if there is an interface called IMeshSceneNode, then there is probably a CMeshSceneNode class as well. It
will implement the functions that you are talking about......
Seven
Posts: 920
Joined: Mon Nov 14, 2005 2:03 pm
ICQ
Top

Re: Custom scene node class?
by danielmccarthy » Wed Jun 11, 2014 12:32 am
I did try to extend that but it was not found at least I think. It said something like class ... and some other stuff
and the last time that happened it was because their was no reference for it I think. Their is how ever that file
in the source of irrlicht so I will take it from their and put it in my project.
Thanks
danielmccarthy
Posts: 51
Joined: Fri May 30, 2014 12:55 am
Top

Re: Custom scene node class?
by Seven » Wed Jun 11, 2014 1:40 am
you can add that folder to your include / source directories and then you can derive directly from those
classes
Seven
Posts: 920
Joined: Mon Nov 14, 2005 2:03 pm
ICQ
Top

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - Custom scene node class?

3 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49950

Re: Custom scene node class?
by lumirion » Fri Jun 13, 2014 7:27 pm
Make a copy of IMeshSceneNode.h and rename it as your custom nodes name. Rename its refrences to
IMeshSceneNode to your custom name. Derive from the IMeshSceneNode with
class CustomSceneNode : public IMeshSceneNode
but copy the implementations from CMeshSceneNode and paste them into the stubs of your
CustomSceneNode.h or in a CustomSceneNode.cpp .
All functions provided in IMeshSceneNode must be implemented in your derived version. The function
names and parameters must be the same but you can customize the implementations or add your own
additional functions.
lumirion
Posts: 79
Joined: Tue Sep 13, 2011 7:35 am
Top

Re: Custom scene node class?
by danielmccarthy » Fri Jun 20, 2014 8:00 pm
Hi guys I am getting an undefined reference to a printer class thing when extending that class. All the
includes are put in that folder
danielmccarthy
Posts: 51
Joined: Fri May 30, 2014 12:55 am
Top

Re: Custom scene node class?
by Destructavator » Sun Jun 22, 2014 10:13 pm
Perhaps I can help, as for my own project I extend scene nodes of different types and create my own all the
time.
Can you please:
- Copy and paste the exact error(s) from your compiler / linker here (If there are many, most likely only the
first few lines would probably be relevant, the ones where it mentions the undefined reference)?
- Also, if you could copy and paste the header file for your custom scene node class here, or at least the parts
you think it is complaining about, it could really help. (I'm not really concerned with the .cpp source file, just
your header, especially the functions in the header and your exact syntax for them.)

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - Custom scene node class?

4 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49950

BTW, make sure you are not just having the right files in available folders in the compiler or IDE's search
path, but also that you #include the proper source headers as needed (Note that to #include "irrlicht.h" alone
might not be enough in this specific case, as the main irrlicht header won't necessarily give you all the "C"
prefixed classes and such, it mostly gives you just the ones from the files that start with "I" or "S", etc.).
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: Custom scene node class?
by mongoose7 » Mon Jun 23, 2014 1:45 am
He's probably referring to os::Printer::log, which requires a header. "A printer class thing" is just lazy - I
guess he really doesn't want help?
mongoose7
Posts: 1227
Joined: Wed Apr 06, 2011 12:13 pm
Top

Re: Custom scene node class?
by CuteAlien » Mon Jun 23, 2014 11:48 am
There are very few reasons to copy the code of the implementations. Nearly always when you make custom
scenenodes you will only need meshes and driver functions inside. Both of which are available as public
interfaces.
Can't help more without knowing more details about what you are trying to do.
Also one general hint - give us as much information as you can when asking for help. When you got an error
don't say I got an error that's like that and that - instead _always_ copy&paste the exact error. Preferably
showing as well some code. Compiler and linker errors are already as minimal as they can be, so when you
don't paste them completely you remove information which others need to help you.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - Custom scene node class?

5 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49950

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Custom scene node class?
by lumirion » Mon Jun 23, 2014 9:32 pm
In my custom node I commented out the os::Printer::log bit. It only acted up in debug mode. I copied and
pasted the implementations initially because I couldn't figure out how to get them to inherit. The linker kept
erroring out, probably because I'm using irrlicht as a dll.
lumirion
Posts: 79
Joined: Tue Sep 13, 2011 7:35 am
Top
Display posts from previous:

Sort by

Post a reply
10 posts • Page 1 of 1
Return to Advanced Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - How can I set more than one material type f...

1 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49915

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Advanced Help
Change font size
Print view
FAQ
Register
Login

How can I set more than one material type for the node
Post a reply

5 posts • Page 1 of 1

How can I set more than one material type for the node
by yuange » Thu May 29, 2014 8:19 am
Hi!
I have create a IAnimatedMeshSceneNode to load a animatedMesh, and wrote a lighting shader and a
shadow shader with GLSL. Now I need to add both lighting effect and shadow effect to the same
animatedMeshSceneNode using setMaterialType(). I tried to call setMaterialType() twice. But the second will
cover the first type I set. How can I realize it.
If anynone have a good idea, please let me know. Thanks a lot!
yuange
Posts: 2
Joined: Thu May 29, 2014 8:11 am
Top

9/6/2019, 4:00 PM

Irrlicht Engine • View topic - How can I set more than one material type f...

2 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49915

Re: How can I set more than one material type for the node
by The_Glitch » Thu May 29, 2014 8:49 am
Has to be in the same shader. So just make your shader into one file.

The_Glitch
Competition winner
Posts: 523
Joined: Tue Jan 15, 2013 6:36 pm
Top

Re: How can I set more than one material type for the node
by yuange » Tue Jun 03, 2014 3:38 am
Sorry, both the gl_position and gl_FragColor are diffent in the two shaders. How can I put them into one file.
Maybe I can use if...else... in the shader. If I do this, How can I give the flag number in the OnsetConstants().
If anyone knows, please let me know. Thank you very much!
yuange
Posts: 2
Joined: Thu May 29, 2014 8:11 am
Top

Re: How can I set more than one material type for the node
by CuteAlien » Tue Jun 03, 2014 11:39 am
Please no cross-posting th same question into several threads - otherwise the discussion get's split all over the
forum which makes it always very hard to talk about a topic. So I'm going to remove your other post.
I don't get yet what exactly you try to do, but you can pass additional parameters between a vertex and a
fragment shader. If that is not sufficient you might need to do multiple stages. Which means you render
intermediate results into a rendertarget texture. Then you render your scene several times switching materials
in between the rendering. And as last stage you have a shader that combines those intermediate textures. That
last step is usually done by putting them on a quad mesh (2 triangles) which has the screen-size and then pass
the intermediate textures as textures for that quad. I heard XEffects also works like that, so you might take a
look at that.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

9/6/2019, 4:00 PM

Irrlicht Engine • View topic - How can I set more than one material type f...

3 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49915

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: How can I set more than one material type for the node
by Destructavator » Sun Jun 22, 2014 11:13 pm
yuange wrote:Hi!
I have create a IAnimatedMeshSceneNode to load a animatedMesh, and wrote a lighting shader
and a shadow shader with GLSL. Now I need to add both lighting effect and shadow effect to the
same animatedMeshSceneNode using setMaterialType(). I tried to call setMaterialType() twice.
But the second will cover the first type I set. How can I realize it.
If anynone have a good idea, please let me know. Thanks a lot!

I think I see what you're really looking for here, how to implement multiple GL textures in the fragment
shader, yes? I ran into this issue myself when I was new with Irrlicht and OpenGL, trying to have multiple
texture samplers in the fragment shader, such as:
sampler2D texA;
sampler2D texB;
...and then making texture() calls to both, to mix multiple image textures.
If I'm getting you right, what you want is *ONE* Irrlicht material, which has a different graphic image
texture on different layers. If you look at the SMaterial class, you'll see that an Irrlicht material has more than
one layer. If you haven't re-compiled the engine and are using a regular release build you downloaded, you
probably have a limit of 4 layers max for any Irrlicht material. (By editing the configuration header and
tweaking a #define, you can bump it all the way up to 8, assuming your graphics card supports it.)
So look at the SMaterial interface, the functions is has for stuff with the different layers, you should be able
to figure it out. Finally, after setting up your material with multiple layers, you call setMaterial() with the one,
multi-layered material, and so forth (if you need more help further than that, just ask)...
EDIT: Whoops! My fault, I read your post too quickly. For shadows, you want a shadow sampler in the
shader, not a standard one.
Take a look at: http://www.opengl.org/sdk/docs/man4/index.php and choose the entry "texture" from the
index on the left pane, and read about how it applies to shadow samplers.
Another helpful resource: http://www.opengl.org/wiki/Sampler_%28GLSL%29
9/6/2019, 4:00 PM

Irrlicht Engine • View topic - How can I set more than one material type f...

4 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=4&t=49915

---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
Display posts from previous:

Sort by

Post a reply
5 posts • Page 1 of 1
Return to Advanced Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 4:00 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

1 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Other Irrlicht Stuff ‹ Open Discussion and Dev Announcements
Change font size
Print view
FAQ
Register
Login

I got "trunk" built/working with MinGW-64 1.0, any
Post a reply

12 posts • Page 1 of 1

I got "trunk" built/working with MinGW-64 1.0, any
by Destructavator » Mon Mar 21, 2011 8:53 pm
EDIT: The forum software happily clipped off part of the subject line, it was originally "I got "trunk"
built/working with MinGW-64 1.0, anyone else had luck with this?"
Hi,
I did a quick forum search and didn't find much as far as other people that have tried this*, but after
downloading and setting up the newly released version of MinGW-64, the one that is considered to be the
"stable" 1.0 release (according to their website), I was able to build the trunk SVN version of Irrlicht in
Code::Blocks and get a working DLL.
The resulting DLL seems to be working when building and running the SDK example programs, in 64 bits.
On my Windows 7 machine it runs without malfunction and it runs FAST.
I wouldn't call it a complete success though, as I had to comment out and tweak a few things in the Irrlicht
SDK source code.
9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

2 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

I'm posting this here (hopefully in the right place in the forum, if not I apologize) because I wanted to know if
anyone else has tried this and what their results were, by comparison.
Here is what I had to do to re-build the SDK in 64 bits without (apparent) errors and such:
- In the C::B project settings, I changed the WIN32 define to WIN64
- In "os.cpp" I had to add a " = 0" to the end of line 108 to overcome a compile error. So the code:
Code: Select all
#if !defined(_WIN32_WCE) && !defined (_IRR_XBOX_PLATFORM_)
// Avoid potential timing inaccuracies across multiple cores by
// temporarily setting the affinity of this process to one core.
DWORD_PTR affinityMask;
if(MultiCore)
affinityMask = SetThreadAffinityMask(GetCurrentThread(), 1);
#endif

...became:
Code: Select all
#if !defined(_WIN32_WCE) && !defined (_IRR_XBOX_PLATFORM_)
// Avoid potential timing inaccuracies across multiple cores by
// temporarily setting the affinity of this process to one core.
DWORD_PTR affinityMask = 0;
if(MultiCore)
affinityMask = SetThreadAffinityMask(GetCurrentThread(), 1);
#endif

I haven't yet done extensive testing to see if this broke any programs yet or not. **
- In "CIrrDeviceWin32.cpp" I had to comment out all the lines of #defines for PRODUCT_* which were
lines 1058 to about 1077. MinGW 64 really complained about these being already defined.
- I had to tweak the compile config header to build withOUT the console device. This one I tried to find a
better solution for, but I couldn't make anything else I tried work. ** This is one of the bigger reasons I'm
posting this, to see if someone else has a better solution.
BTW, I also have the compiler options:
-m64
-static-libgcc
... and the linker options:
-m64
9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

3 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

-static-libstdc++
-static-libgcc
...set in the C::B global compiler settings.
So, anyone else have better luck or advice?
* I did see one older post where someone posted a diff, but it looked like they had other issues trying to make
it work.
** As I'm sure you can tell I'm a bit of a novice programmer, and I don't claim to be an expert. I'm one of
those "self-taught" types from a few books and Internet, and still learning.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Tue Mar 22, 2011 4:14 am
I noticed the changes in the SVN for the 1.7 branch just now, and yes, those parts of the SDK seem to
compile OK now. (Don't tell me my inexperienced programming skills got to the point where I was actually
*right* about something?)
I probably should have posted this info as well in my first post, but here is the remaining issue with the
console device and MinGW 64:
The compiler is complaining about this section in CIrrDeviceConsole.cpp:
Code: Select all
#ifdef _IRR_WINDOWS_NT_CONSOLE_
MouseButtonStates = 0;
WindowsSTDIn = GetStdHandle(STD_INPUT_HANDLE);
WindowsSTDOut = GetStdHandle(STD_OUTPUT_HANDLE);
PCOORD Dimensions = 0;
if (CreationParams.Fullscreen)
{
if (SetConsoleDisplayMode(WindowsSTDOut, CONSOLE_FULLSCREEN_MODE, Dimensions))
{

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

4 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

CreationParams.WindowSize.Width = Dimensions->X;
CreationParams.WindowSize.Width = Dimensions->Y;
}
}
else
{
COORD ConsoleSize;
ConsoleSize.X = CreationParams.WindowSize.Width;
ConsoleSize.X = CreationParams.WindowSize.Height;
SetConsoleScreenBufferSize(WindowsSTDOut, ConsoleSize);
}
// catch windows close/break signals
SetConsoleCtrlHandler((PHANDLER_ROUTINE)ConsoleHandler, TRUE);

Specifically, it points to line 80:
Code: Select all
if (SetConsoleDisplayMode(WindowsSTDOut, CONSOLE_FULLSCREEN_MODE, Dimensions))

With the errors:
E:\irrlicht-export\irrlicht\branches\releases\1.7\source\Irrlicht\CIrrDeviceConsole.cpp|80|error:
'CONSOLE_FULLSCREEN_MODE' was not declared in this scope|
E:\irrlicht-export\irrlicht\branches\releases\1.7\source\Irrlicht\CIrrDeviceConsole.cpp|80|error:
'SetConsoleDisplayMode' was not declared in this scope|
PLEASE NOTE that this is with the 1.7 branch now, my first post detailed what I experienced with the trunk.
(I went over to the 1.7 branch because that is where the latest SVN fixes were applied.)
BTW, In C::B I right-clicked on "CONSOLE_FULLSCREEN_MODE" and went through three options, one
to "Find declaration of CONSOLE_FULLSCREEN_MODE", one to "Find implementation of
CONSOLE_FULLSCREEN_MODE", and one to "Find occurrences of
CONSOLE_FULLSCREEN_MODE". In the first two cases I got zero results. In the third I only got one, just
the occurrence in the source code file generating the error, CIrrDeviceConsole.cpp.
Looking at the surrounding code I notice what look like possible references to STD (standard library?) files,
which I know for a fact from the MinGW 64 docs are a little different than the "normal" MinGW stuff.
If I had to guess, I'd say that CONSOLE_FULLSCREEN_MODE either isn't in MinGW 64 or is simply
called something else.
If I'm totally on the wrong track, please correct me.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

5 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Tue Mar 22, 2011 4:22 am
Wait a sec... I did a search on the actual function name, which wasn't understood by the compiler either (the
second error).
I got popups about missing source code files!
Specifically, missing "jchuff.h" and "jdhuff.h" which were expected in Irrlicht/jpeglib/*.*
Perhaps these two files have the missing declarations and such, and were accidentally left out?
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Tue Mar 22, 2011 4:56 am
OK, I did some more research. (Isn't Google nice?)
The errors have to do with stuff from windows.h and console.h. Apparently when calling stuff from
console.h, sometimes "#define _WIN32_WINNT 0x500" needs to be done before "#include <windows.h>" is
called. I found a short discussion on it, along with similar compile errors, here:
http://cboard.cprogramming.com/cplusplu ... error.html
Now, granted this link goes to posts from 2006, but I'm guessing part of it *might* be relevant to stuff in
MinGW 64 that's different from the regular 32-bit version.
Hang on, I'm going to check a few things and do a little more research...
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

6 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Tue Mar 22, 2011 5:09 am
Well, here's the wincon.h file in the stable 1.0 of MinGW 64, although I'm still not sure I'm even on the right
track here:
Code: Select all
/**
* This file has no copyright assigned and is placed in the Public Domain.
* This file is part of the w64 mingw-runtime package.
* No warranty is given; refer to the file DISCLAIMER.PD within this package.
*/
#ifndef _WINCON_
#define _WINCON_
#ifdef __cplusplus
extern "C" {
#endif
typedef struct _COORD {
SHORT X;
SHORT Y;
} COORD,*PCOORD;
typedef struct _SMALL_RECT {
SHORT Left;
SHORT Top;
SHORT Right;
SHORT Bottom;
} SMALL_RECT,*PSMALL_RECT;
typedef struct _KEY_EVENT_RECORD {
WINBOOL bKeyDown;
WORD wRepeatCount;
WORD wVirtualKeyCode;
WORD wVirtualScanCode;
union {
WCHAR UnicodeChar;
CHAR AsciiChar;

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

7 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

} uChar;
DWORD dwControlKeyState;
} KEY_EVENT_RECORD,*PKEY_EVENT_RECORD;
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define

RIGHT_ALT_PRESSED 0x1
LEFT_ALT_PRESSED 0x2
RIGHT_CTRL_PRESSED 0x4
LEFT_CTRL_PRESSED 0x8
SHIFT_PRESSED 0x10
NUMLOCK_ON 0x20
SCROLLLOCK_ON 0x40
CAPSLOCK_ON 0x80
ENHANCED_KEY 0x100
NLS_DBCSCHAR 0x10000
NLS_ALPHANUMERIC 0x0
NLS_KATAKANA 0x20000
NLS_HIRAGANA 0x40000
NLS_ROMAN 0x400000
NLS_IME_CONVERSION 0x800000
NLS_IME_DISABLE 0x20000000

typedef struct _MOUSE_EVENT_RECORD {
COORD dwMousePosition;
DWORD dwButtonState;
DWORD dwControlKeyState;
DWORD dwEventFlags;
} MOUSE_EVENT_RECORD,*PMOUSE_EVENT_RECORD;
#define
#define
#define
#define
#define

FROM_LEFT_1ST_BUTTON_PRESSED
RIGHTMOST_BUTTON_PRESSED 0x2
FROM_LEFT_2ND_BUTTON_PRESSED
FROM_LEFT_3RD_BUTTON_PRESSED
FROM_LEFT_4TH_BUTTON_PRESSED

0x1
0x4
0x8
0x10

#define MOUSE_MOVED 0x1
#define DOUBLE_CLICK 0x2
#define MOUSE_WHEELED 0x4
typedef struct _WINDOW_BUFFER_SIZE_RECORD {
COORD dwSize;
} WINDOW_BUFFER_SIZE_RECORD,*PWINDOW_BUFFER_SIZE_RECORD;
typedef struct _MENU_EVENT_RECORD {
UINT dwCommandId;
} MENU_EVENT_RECORD,*PMENU_EVENT_RECORD;
typedef struct _FOCUS_EVENT_RECORD {
WINBOOL bSetFocus;
} FOCUS_EVENT_RECORD,*PFOCUS_EVENT_RECORD;
typedef struct _INPUT_RECORD {

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

8 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

WORD EventType;
union {
KEY_EVENT_RECORD KeyEvent;
MOUSE_EVENT_RECORD MouseEvent;
WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
MENU_EVENT_RECORD MenuEvent;
FOCUS_EVENT_RECORD FocusEvent;
} Event;
} INPUT_RECORD,*PINPUT_RECORD;
#define
#define
#define
#define
#define

KEY_EVENT 0x1
MOUSE_EVENT 0x2
WINDOW_BUFFER_SIZE_EVENT 0x4
MENU_EVENT 0x8
FOCUS_EVENT 0x10

typedef struct _CHAR_INFO {
union {
WCHAR UnicodeChar;
CHAR AsciiChar;
} Char;
WORD Attributes;
} CHAR_INFO,*PCHAR_INFO;
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define

FOREGROUND_BLUE 0x1
FOREGROUND_GREEN 0x2
FOREGROUND_RED 0x4
FOREGROUND_INTENSITY 0x8
BACKGROUND_BLUE 0x10
BACKGROUND_GREEN 0x20
BACKGROUND_RED 0x40
BACKGROUND_INTENSITY 0x80
COMMON_LVB_LEADING_BYTE 0x100
COMMON_LVB_TRAILING_BYTE 0x200
COMMON_LVB_GRID_HORIZONTAL 0x400
COMMON_LVB_GRID_LVERTICAL 0x800
COMMON_LVB_GRID_RVERTICAL 0x1000
COMMON_LVB_REVERSE_VIDEO 0x4000
COMMON_LVB_UNDERSCORE 0x8000

#define COMMON_LVB_SBCSDBCS 0x300
typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
COORD dwSize;
COORD dwCursorPosition;
WORD wAttributes;
SMALL_RECT srWindow;
COORD dwMaximumWindowSize;
} CONSOLE_SCREEN_BUFFER_INFO,*PCONSOLE_SCREEN_BUFFER_INFO;
typedef struct _CONSOLE_CURSOR_INFO {

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

9 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

DWORD dwSize;
WINBOOL bVisible;
} CONSOLE_CURSOR_INFO,*PCONSOLE_CURSOR_INFO;
typedef struct _CONSOLE_FONT_INFO {
DWORD nFont;
COORD dwFontSize;
} CONSOLE_FONT_INFO,*PCONSOLE_FONT_INFO;
typedef struct _CONSOLE_SELECTION_INFO {
DWORD dwFlags;
COORD dwSelectionAnchor;
SMALL_RECT srSelection;
} CONSOLE_SELECTION_INFO,*PCONSOLE_SELECTION_INFO;
#define
#define
#define
#define
#define

CONSOLE_NO_SELECTION 0x0
CONSOLE_SELECTION_IN_PROGRESS 0x1
CONSOLE_SELECTION_NOT_EMPTY 0x2
CONSOLE_MOUSE_SELECTION 0x4
CONSOLE_MOUSE_DOWN 0x8

typedef WINBOOL (WINAPI *PHANDLER_ROUTINE)(DWORD CtrlType);
#define CTRL_C_EVENT 0
#define CTRL_BREAK_EVENT 1
#define CTRL_CLOSE_EVENT 2
#define CTRL_LOGOFF_EVENT 5
#define CTRL_SHUTDOWN_EVENT 6
#define
#define
#define
#define
#define

ENABLE_PROCESSED_INPUT 0x1
ENABLE_LINE_INPUT 0x2
ENABLE_ECHO_INPUT 0x4
ENABLE_WINDOW_INPUT 0x8
ENABLE_MOUSE_INPUT 0x10

#define ENABLE_PROCESSED_OUTPUT 0x1
#define ENABLE_WRAP_AT_EOL_OUTPUT 0x2
#ifdef UNICODE
#define PeekConsoleInput PeekConsoleInputW
#define ReadConsoleInput ReadConsoleInputW
#define WriteConsoleInput WriteConsoleInputW
#define ReadConsoleOutput ReadConsoleOutputW
#define WriteConsoleOutput WriteConsoleOutputW
#define ReadConsoleOutputCharacter ReadConsoleOutputCharacterW
#define WriteConsoleOutputCharacter WriteConsoleOutputCharacterW
#define FillConsoleOutputCharacter FillConsoleOutputCharacterW
#define ScrollConsoleScreenBuffer ScrollConsoleScreenBufferW
#define GetConsoleTitle GetConsoleTitleW
#define SetConsoleTitle SetConsoleTitleW

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

10 of 18

#define
#define
#define
#define
#define
#define
#define
#define
#else
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#define
#endif

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

ReadConsole ReadConsoleW
WriteConsole WriteConsoleW
AddConsoleAlias AddConsoleAliasW
GetConsoleAlias GetConsoleAliasW
GetConsoleAliasesLength GetConsoleAliasesLengthW
GetConsoleAliasExesLength GetConsoleAliasExesLengthW
GetConsoleAliases GetConsoleAliasesW
GetConsoleAliasExes GetConsoleAliasExesW
PeekConsoleInput PeekConsoleInputA
ReadConsoleInput ReadConsoleInputA
WriteConsoleInput WriteConsoleInputA
ReadConsoleOutput ReadConsoleOutputA
WriteConsoleOutput WriteConsoleOutputA
ReadConsoleOutputCharacter ReadConsoleOutputCharacterA
WriteConsoleOutputCharacter WriteConsoleOutputCharacterA
FillConsoleOutputCharacter FillConsoleOutputCharacterA
ScrollConsoleScreenBuffer ScrollConsoleScreenBufferA
GetConsoleTitle GetConsoleTitleA
SetConsoleTitle SetConsoleTitleA
ReadConsole ReadConsoleA
WriteConsole WriteConsoleA
AddConsoleAlias AddConsoleAliasA
GetConsoleAlias GetConsoleAliasA
GetConsoleAliasesLength GetConsoleAliasesLengthA
GetConsoleAliasExesLength GetConsoleAliasExesLengthA
GetConsoleAliases GetConsoleAliasesA
GetConsoleAliasExes GetConsoleAliasExesA

WINBASEAPI WINBOOL WINAPI PeekConsoleInputA(HANDLE hConsoleInput,PINPUT_RECORD
lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsRead);
WINBASEAPI WINBOOL WINAPI PeekConsoleInputW(HANDLE hConsoleInput,PINPUT_RECORD
lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsRead);
WINBASEAPI WINBOOL WINAPI ReadConsoleInputA(HANDLE hConsoleInput,PINPUT_RECORD
lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsRead);
WINBASEAPI WINBOOL WINAPI ReadConsoleInputW(HANDLE hConsoleInput,PINPUT_RECORD
lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsRead);
WINBASEAPI WINBOOL WINAPI WriteConsoleInputA(HANDLE hConsoleInput,CONST
INPUT_RECORD *lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsWritten);
WINBASEAPI WINBOOL WINAPI WriteConsoleInputW(HANDLE hConsoleInput,CONST
INPUT_RECORD *lpBuffer,DWORD nLength,LPDWORD lpNumberOfEventsWritten);
WINBASEAPI WINBOOL WINAPI ReadConsoleOutputA(HANDLE hConsoleOutput,PCHAR_INFO
lpBuffer,COORD dwBufferSize,COORD dwBufferCoord,PSMALL_RECT lpReadRegion);
WINBASEAPI WINBOOL WINAPI ReadConsoleOutputW(HANDLE hConsoleOutput,PCHAR_INFO
lpBuffer,COORD dwBufferSize,COORD dwBufferCoord,PSMALL_RECT lpReadRegion);
WINBASEAPI WINBOOL WINAPI WriteConsoleOutputA(HANDLE hConsoleOutput,CONST CHAR_INFO
*lpBuffer,COORD dwBufferSize,COORD dwBufferCoord,PSMALL_RECT lpWriteRegion);
WINBASEAPI WINBOOL WINAPI WriteConsoleOutputW(HANDLE hConsoleOutput,CONST CHAR_INFO
*lpBuffer,COORD dwBufferSize,COORD dwBufferCoord,PSMALL_RECT lpWriteRegion);
WINBASEAPI WINBOOL WINAPI ReadConsoleOutputCharacterA(HANDLE hConsoleOutput,LPSTR

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

11 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

lpCharacter,DWORD nLength,COORD dwReadCoord,LPDWORD lpNumberOfCharsRead);
WINBASEAPI WINBOOL WINAPI ReadConsoleOutputCharacterW(HANDLE hConsoleOutput,LPWSTR
lpCharacter,DWORD nLength,COORD dwReadCoord,LPDWORD lpNumberOfCharsRead);
WINBASEAPI WINBOOL WINAPI ReadConsoleOutputAttribute(HANDLE hConsoleOutput,LPWORD
lpAttribute,DWORD nLength,COORD dwReadCoord,LPDWORD lpNumberOfAttrsRead);
WINBASEAPI WINBOOL WINAPI WriteConsoleOutputCharacterA(HANDLE hConsoleOutput,LPCSTR
lpCharacter,DWORD nLength,COORD dwWriteCoord,LPDWORD lpNumberOfCharsWritten);
WINBASEAPI WINBOOL WINAPI WriteConsoleOutputCharacterW(HANDLE
hConsoleOutput,LPCWSTR lpCharacter,DWORD nLength,COORD dwWriteCoord,LPDWORD
lpNumberOfCharsWritten);
WINBASEAPI WINBOOL WINAPI WriteConsoleOutputAttribute(HANDLE hConsoleOutput,CONST
WORD *lpAttribute,DWORD nLength,COORD dwWriteCoord,LPDWORD lpNumberOfAttrsWritten);
WINBASEAPI WINBOOL WINAPI FillConsoleOutputCharacterA(HANDLE hConsoleOutput,CHAR
cCharacter,DWORD nLength,COORD dwWriteCoord,LPDWORD lpNumberOfCharsWritten);
WINBASEAPI WINBOOL WINAPI FillConsoleOutputCharacterW(HANDLE hConsoleOutput,WCHAR
cCharacter,DWORD nLength,COORD dwWriteCoord,LPDWORD lpNumberOfCharsWritten);
WINBASEAPI WINBOOL WINAPI FillConsoleOutputAttribute(HANDLE hConsoleOutput,WORD
wAttribute,DWORD nLength,COORD dwWriteCoord,LPDWORD lpNumberOfAttrsWritten);
WINBASEAPI WINBOOL WINAPI GetConsoleMode(HANDLE hConsoleHandle,LPDWORD lpMode);
WINBASEAPI WINBOOL WINAPI GetNumberOfConsoleInputEvents(HANDLE
hConsoleInput,LPDWORD lpNumberOfEvents);
WINBASEAPI WINBOOL WINAPI GetConsoleScreenBufferInfo(HANDLE
hConsoleOutput,PCONSOLE_SCREEN_BUFFER_INFO lpConsoleScreenBufferInfo);
WINBASEAPI COORD WINAPI GetLargestConsoleWindowSize(HANDLE hConsoleOutput);
WINBASEAPI WINBOOL WINAPI GetConsoleCursorInfo(HANDLE
hConsoleOutput,PCONSOLE_CURSOR_INFO lpConsoleCursorInfo);
WINBASEAPI WINBOOL WINAPI GetCurrentConsoleFont(HANDLE hConsoleOutput,WINBOOL
bMaximumWindow,PCONSOLE_FONT_INFO lpConsoleCurrentFont);
WINBASEAPI COORD WINAPI GetConsoleFontSize(HANDLE hConsoleOutput,DWORD nFont);
WINBASEAPI WINBOOL WINAPI GetConsoleSelectionInfo(PCONSOLE_SELECTION_INFO
lpConsoleSelectionInfo);
WINBASEAPI WINBOOL WINAPI GetNumberOfConsoleMouseButtons(LPDWORD
lpNumberOfMouseButtons);
WINBASEAPI WINBOOL WINAPI SetConsoleMode(HANDLE hConsoleHandle,DWORD dwMode);
WINBASEAPI WINBOOL WINAPI SetConsoleActiveScreenBuffer(HANDLE hConsoleOutput);
WINBASEAPI WINBOOL WINAPI FlushConsoleInputBuffer(HANDLE hConsoleInput);
WINBASEAPI WINBOOL WINAPI SetConsoleScreenBufferSize(HANDLE hConsoleOutput,COORD
dwSize);
WINBASEAPI WINBOOL WINAPI SetConsoleCursorPosition(HANDLE hConsoleOutput,COORD
dwCursorPosition);
WINBASEAPI WINBOOL WINAPI SetConsoleCursorInfo(HANDLE hConsoleOutput,CONST
CONSOLE_CURSOR_INFO *lpConsoleCursorInfo);
WINBASEAPI WINBOOL WINAPI ScrollConsoleScreenBufferA(HANDLE hConsoleOutput,CONST
SMALL_RECT *lpScrollRectangle,CONST SMALL_RECT *lpClipRectangle,COORD
dwDestinationOrigin,CONST CHAR_INFO *lpFill);
WINBASEAPI WINBOOL WINAPI ScrollConsoleScreenBufferW(HANDLE hConsoleOutput,CONST
SMALL_RECT *lpScrollRectangle,CONST SMALL_RECT *lpClipRectangle,COORD
dwDestinationOrigin,CONST CHAR_INFO *lpFill);
WINBASEAPI WINBOOL WINAPI SetConsoleWindowInfo(HANDLE hConsoleOutput,WINBOOL
bAbsolute,CONST SMALL_RECT *lpConsoleWindow);
WINBASEAPI WINBOOL WINAPI SetConsoleTextAttribute(HANDLE hConsoleOutput,WORD

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

12 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

wAttributes);
WINBASEAPI WINBOOL WINAPI SetConsoleCtrlHandler(PHANDLER_ROUTINE
HandlerRoutine,WINBOOL Add);
WINBASEAPI WINBOOL WINAPI GenerateConsoleCtrlEvent(DWORD dwCtrlEvent,DWORD
dwProcessGroupId);
WINBASEAPI WINBOOL WINAPI AllocConsole(VOID);
WINBASEAPI WINBOOL WINAPI FreeConsole(VOID);
WINBASEAPI WINBOOL WINAPI AttachConsole(DWORD dwProcessId);
#define ATTACH_PARENT_PROCESS ((DWORD)-1)
WINBASEAPI DWORD WINAPI GetConsoleTitleA(LPSTR lpConsoleTitle,DWORD nSize);
WINBASEAPI DWORD WINAPI GetConsoleTitleW(LPWSTR lpConsoleTitle,DWORD nSize);
WINBASEAPI WINBOOL WINAPI SetConsoleTitleA(LPCSTR lpConsoleTitle);
WINBASEAPI WINBOOL WINAPI SetConsoleTitleW(LPCWSTR lpConsoleTitle);
WINBASEAPI WINBOOL WINAPI ReadConsoleA(HANDLE hConsoleInput,LPVOID lpBuffer,DWORD
nNumberOfCharsToRead,LPDWORD lpNumberOfCharsRead,LPVOID lpReserved);
WINBASEAPI WINBOOL WINAPI ReadConsoleW(HANDLE hConsoleInput,LPVOID lpBuffer,DWORD
nNumberOfCharsToRead,LPDWORD lpNumberOfCharsRead,LPVOID lpReserved);
WINBASEAPI WINBOOL WINAPI WriteConsoleA(HANDLE hConsoleOutput,CONST VOID
*lpBuffer,DWORD nNumberOfCharsToWrite,LPDWORD lpNumberOfCharsWritten,LPVOID
lpReserved);
WINBASEAPI WINBOOL WINAPI WriteConsoleW(HANDLE hConsoleOutput,CONST VOID
*lpBuffer,DWORD nNumberOfCharsToWrite,LPDWORD lpNumberOfCharsWritten,LPVOID
lpReserved);
#define CONSOLE_TEXTMODE_BUFFER 1
WINBASEAPI HANDLE WINAPI CreateConsoleScreenBuffer(DWORD dwDesiredAccess,DWORD
dwShareMode,CONST SECURITY_ATTRIBUTES *lpSecurityAttributes,DWORD dwFlags,LPVOID
lpScreenBufferData);
WINBASEAPI UINT WINAPI GetConsoleCP(VOID);
WINBASEAPI WINBOOL WINAPI SetConsoleCP(UINT wCodePageID);
WINBASEAPI UINT WINAPI GetConsoleOutputCP(VOID);
WINBASEAPI WINBOOL WINAPI SetConsoleOutputCP(UINT wCodePageID);
#define CONSOLE_FULLSCREEN 1
#define CONSOLE_FULLSCREEN_HARDWARE 2
WINBASEAPI WINBOOL WINAPI GetConsoleDisplayMode(LPDWORD lpModeFlags);
WINBASEAPI HWND WINAPI GetConsoleWindow(VOID);
WINBASEAPI DWORD WINAPI GetConsoleProcessList(LPDWORD lpdwProcessList,DWORD
dwProcessCount);
WINBASEAPI WINBOOL WINAPI AddConsoleAliasA(LPSTR Source,LPSTR Target,LPSTR
ExeName);
WINBASEAPI WINBOOL WINAPI AddConsoleAliasW(LPWSTR Source,LPWSTR Target,LPWSTR
ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasA(LPSTR Source,LPSTR TargetBuffer,DWORD
TargetBufferLength,LPSTR ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasW(LPWSTR Source,LPWSTR TargetBuffer,DWORD
TargetBufferLength,LPWSTR ExeName);

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

13 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

WINBASEAPI DWORD WINAPI GetConsoleAliasesLengthA(LPSTR ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasesLengthW(LPWSTR ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasExesLengthA(VOID);
WINBASEAPI DWORD WINAPI GetConsoleAliasExesLengthW(VOID);
WINBASEAPI DWORD WINAPI GetConsoleAliasesA(LPSTR AliasBuffer,DWORD
AliasBufferLength,LPSTR ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasesW(LPWSTR AliasBuffer,DWORD
AliasBufferLength,LPWSTR ExeName);
WINBASEAPI DWORD WINAPI GetConsoleAliasExesA(LPSTR ExeNameBuffer,DWORD
ExeNameBufferLength);
WINBASEAPI DWORD WINAPI GetConsoleAliasExesW(LPWSTR ExeNameBuffer,DWORD
ExeNameBufferLength);
#ifdef __cplusplus
}
#endif
#endif

I don't see any "SetConsoleDisplayMode" function in there.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Destructavator » Tue Mar 22, 2011 5:17 am
OK, I just checked the wincon.h file from the official 32-bit regular MinGW compiler include files, and
compared it with the one I just posted that's in MinGW 64.
Yup, they look totally different, and the 32-bit standard version does indeed have that function listed in there,
the 64-bit version does not.
It looks like MinGW-64 has a very different implementation for console, and/or has different function names
compared to the standard 32-bit MinGW.
I'd also like to point out that the 64-bit version is a much larger header file, with a lot more stuff in it.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

14 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by hybrid » Tue Mar 22, 2011 8:21 am
Thanks for the response. You might want to look into the functionality of the edit button of your latest post,
as this reduces the overhead of mass posting.
The changes for Irrlicht go either into SVN/trunk (mostly in cases of API breaking functionality) or the
release branches (for bug fixing). Since your changes were only minor bug fixes, they went into the 1.7
branch. These changes are merged from time to time into trunk.
hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top
by Destructavator » Wed Mar 23, 2011 1:31 pm
Sorry about the posting issue.
I noticed just today that the fixes for MinGW 64 support broke compilation for some of the MS compilers.
I think I can offer some help here in having the Irrlicht SDK code better detect exactly what compiler is being
used and how to proceed. Although I'd like to point out a few things first, from what I've gathered. (If any of
what I say next is incorrect, anyone is more than welcome to jump in and correct me.)
First, there's two main 64-bit packages of MinGW on Windows (actually more I think, but at least two main
ones that are common that I'm familiar with).
- There's the "official" 1.0 MinGW w64 release (which just a few days ago reached what they call 1.0 stable).
- There's the TDM (Twilight Dragon Media) builds, which are based upon MinGW w64, and as of the time of
this post are still using 4.5.1 but are expecting a 4.5.2 release any day now.
Both builds are available from SourceForge.
The FAQ for the official project actually recommends the TDM builds, especially for the inexperienced, and
I've seen elsewhere on the net that newcomer programmers getting started have an easier time with TDM
builds because they don't require as much setup work, they pretty much run "out of the box" unlike the
official MinGW w64 project (sometimes, depending on what type of code one is building).
9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

15 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

From what I've heard, some people use the official one, some use TDM. What the exact ratio is I'm not sure
of, but the point is that there are more than one major and commonly used versions of a 64 bit version of
MinGW floating around.
According to the TDM page:
As with most other compilers, GCC is a command-line tool that uses named options to control its
operation. An introduction to GCC command-line compilation is beyond the scope of this
discussion, but there are a few MinGW and MinGW-w64 specifics that should be mentioned.
In the MinGW-w64/TDM64 edition, use "-m32" and "-m64" to control whether 32-bit or 64-bit
binaries are generated.
By default (if neither -m32 nor -m64 is specified), this edition will generate 64-bit binaries. In a
64-bit binary, all pointer math is 64-bit by default, and the built-in "size_t" and "ptrdiff_t" types
are 64 bits in size (some other types are larger also). Additionally, the following preprocessor
definitions will be in effect:
* #define _WIN64 1 (also WIN64, __WIN64, and __WIN64__)
* #define __MINGW64__ 1
* #define __x86_64 1 (also __x86_64__)
* #define __amd64 1 (also __amd64__)
Be sure to use "-m32" or "-m64" at both the compile stage and the link stage.

...So if the SDK code checks for those defines from that list, it could be set up to be aware that MinGW 64 is
being used, and build without error.
I'll wait for a few more updates to SVN, then I'll try downloading the TDM 64 build and compare results
building Irrlicht with both of them, to see if one or both do or don't work.
One other, related point: If the variable sizes are different in both builds, will that mess up any of the Irrlicht
data types (Such as u32, f16, s8, and all the other custom types)?
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by hybrid » Wed Mar 23, 2011 2:13 pm

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

16 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

Well, the defines are probably not really related to mingw, and as it seems they are missing in variable
amounts also in other headers. So we need those defines enabled/disabled in a different way, which I tried to
fix today. Just to make it as simple as possible, but working with all common compilers.
The sizes of the types are not changed. This is only a problem for 64bit types, which we are currently
investigating at another place. You might want to check those types once we have added them (to SVN/trunk
then, though).
hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top
by Destructavator » Wed Mar 23, 2011 2:24 pm
OK. I think I understand now.
Will there ever be any options, perhaps in the SDK compiile configuration header, to "force" or override
detection of the compiler, so that when a new version of some compiler comes out and has issues building the
SDK the programmer could un-comment a line to, say, force building Irrlciht as if a specific Microsoft
compiler is being used, or a specific release of MinGW is being used?
Just an idea, feel free to use it if you think it would be a good one.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by hybrid » Wed Mar 23, 2011 2:38 pm
Well, this is the idea behind this 'only as much as necessary' approach. In general, most compilers will behave
the same. If some compiler is missing a thing, we add it for that specific compiler. If it is only missing is a
specific version, we add it only for that version. This should reduce the impact of such conditionals and make
the code work with all conforming compilers. But there's no way that 'faking' a compiler detection would
make the engine's code become more acceptable to a different compiler. We simply have to work around
issues in newer compilers, and hope that all will be standard conforming at some day.

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

17 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top

Re: I got "trunk" built/working with MinGW-64 1.0, any
by JonathanFrisch » Tue Oct 25, 2011 9:05 pm
I'd like to make a contribution to compiling Irrlicht on a x64 machine.
Operating system: Vista Home Premium 64-bit.
First, I set up MinGW according to: http://puredata.info/docs/developer/Windows64BitMinGWX64 using
Note: used "c:\mingw-w64" instead of "c:\mingw_w64" and fstab mounts for /mingw32 and /mingw64. (just
my prefs.)
Second, I installed Code::Blocks without included MinGW.
Note: set up the global toolchain executables as gcc, g++, g++, ar, gdb, windres, mingw32-make and
unchecked all compiler flags. (just my prefs.)
Third, from the Irrlicht project properties duplicate the Win32 Accurate Math (or Debug) dll (or static) build
targets and name it something like "Win64 - Release - dll".
Change the output file name to something like "..\..\lib\Win64-gcc\Irrlicht.dll" and the objects... like "..\obj
\win64-gcc-release-dll".
Then under build options -> compiler options -> #defines, change WIN32 to WIN64 and __GNUWIN32__
to __GNUWIN64__.
::edited from here down
Add
-m64
-fpermissive (to get around precision loss errors in CColladaMeshWriter.cpp -> uniqueNameFor[Mesh/Light
/Node])
to other compiler options.
And add
-m64
to linker settings.
Change post build steps to:
cmd /c del ..\..\bin\Win64-gcc\libIrrlicht.dll
cmd /c cp ..\..\lib\Win64-gcc\libIrrlicht.dll ..\..\bin\Win64-gcc\libIrrlicht.dll
No need to edit Headers/include/IrrCompileConfig.h
That's it.
JonathanFrisch
Posts: 1
9/6/2019, 3:59 PM

Irrlicht Engine • View topic - I got "trunk" built/working with MinGW-64...

18 of 18

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=43401

Joined: Tue Oct 25, 2011 4:15 am
Location: Pensacola, FL, USA
Top
Display posts from previous:

Sort by

Post a reply
12 posts • Page 1 of 1
Return to Open Discussion and Dev Announcements
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:59 PM

Irrlicht Engine • View topic - Improved font rendering system.

1 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Other Irrlicht Stuff ‹ Open Discussion and Dev Announcements
Change font size
Print view
FAQ
Register
Login

Improved font rendering system.
Post a reply

34 posts • Page 2 of 3 • 1, 2, 3

Re: Improved font rendering system.
by superpws » Fri Apr 04, 2014 6:38 am
Did you see any other patch for TT support apart from that? I'm curious to know because Nadro's games
(simple fun games!) uses Freetype along with Irrlicht, so how would he able to implement Freetype in
irrlicht? By using such workarounds? Or did he use lets say CopperCube?
IRC: #irrlicht on irc.freenode.net
Github: https://github.com/danyalzia
Homepage: http://danyalzia.com
superpws
Posts: 18
Joined: Mon Mar 31, 2014 6:47 am
Website
Top

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

2 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Re: Improved font rendering system.
by Nadro » Fri Apr 04, 2014 9:03 am
Hi,
I use this project for TT support in Irrlicht:
viewtopic.php?f=6&t=37296&hilit=truetype
Cheers,
Library helping with network requests, tasks management, logger etc in desktop and mobile apps:
https://github.com/GrupaPracuj/hermes
Nadro
Posts: 1648
Joined: Sun Feb 19, 2006 9:08 am
Location: Warsaw, Poland
Top

Re: Improved font rendering system.
by CuteAlien » Fri Apr 04, 2014 10:42 am
Ah yes - Nalin reworked it some more so it no longer creates 1 Texture per character but puts more on a
single texture. I should switch to that as well I suppose. Or maybe he even wrote it from scratch in which
case we might even be able to use it (I'l ask him - he hangs around the chat sometimes).
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Improved font rendering system.
by superpws » Sat Apr 05, 2014 7:48 am
Very well. The class looks clean and the interface is very similar to irrlicht, but it needs some changes in
trunk to make it work (e.g, core::ustring etc). Maybe it will take it's place in 1.9

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

3 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

IRC: #irrlicht on irc.freenode.net
Github: https://github.com/danyalzia
Homepage: http://danyalzia.com
superpws
Posts: 18
Joined: Mon Mar 31, 2014 6:47 am
Website
Top

Re: Improved font rendering system.
by CuteAlien » Sat Apr 05, 2014 9:56 am
Yeah, Nalin just wrote me that it's written from scratch and put under zlib license. So we can use it. Will try it
out within next weeks in one of my projects to check it out.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Improved font rendering system.
by superpws » Sat Apr 05, 2014 10:23 am
Glad to hear. You should also include compilation flag for Freetype support in IrrCompileConfig.h as
Freetype is licensed under BSD-style license and not everyone use TT fonts so they won't have to comply
with license.
IRC: #irrlicht on irc.freenode.net
Github: https://github.com/danyalzia
Homepage: http://danyalzia.com
superpws
Posts: 18
Joined: Mon Mar 31, 2014 6:47 am
Website

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

4 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Top

Re: Improved font rendering system.
by Destructavator » Thu Jun 19, 2014 6:29 am
Hi, I don't know how much this helps, but for my own project (that I've been getting back to) I have a shaderbased system for rendering fonts in 3D space, actually creating meshbuffers as needed (planes) in arrays onthe-fly, able to be scaled, rotated on any 3D axis, etc. They use a choice of two or three image textures, one
for the foreground, one for a glow / highlight color, and an optional 3rd one for blending with the second with
moving coordinates that allow a shimmer / animated glow look. The custom scene node it is all encapsulated
in currently uses OpenGL shaders with a few attribute variables passed to the shaders that can color both the
foreground letter color as well as the highlight color (including transparency) and part of the beauty of how it
works is that it gets the "attributes" not from regular OpenGL functions, but the mesh buffers use the
"tangents" version of S3DVertex, with the coloring data added in as the "binormal" and "tangent" variables,
the shader code (very simple, I'm sure DirectX versions would be very easy to implement), simply use the
extra data for such coloring, so the mesh buffers don't actually use any real tangents, etc. This also allows
custom coloring per-letter in a displayed string of text, and doesn't require an end-user of the engine to
manually include any GL extension headers or worry about how to check for or use such extensions for
vertex attributes. I realize this is non-standard use of the vertex data in the shaders, but it means that recompiling the engine or going into the source code for it wouldn't be needed.
Actually, for my own project I use a heavily-modified version of Irrlicht based upon the trunk branch, but this
font implementation could probably be done with a standard, official build. Again, the special color
"attributes" are really just the tangent and binormal data being used in the shader for something they weren't
originally intended for.
I have two pics here, one of parts of the font image maps, side by side (the right half shows characters from
the glow / shimmer / highlight layer), although for the actual application I use .png files with alpha
backgrounds instead of black, and a picture of the font node class in action, with the foreground colors as
plain white (255, 255, 255, 255), and the background glow color as black with alpha around ~0.75f (the glow
layer is actually white, with the texels simply multiplied by zero for RGB and 0.75f for alpha).
This system allows for custom graphic fonts as well, which don't require a special font editor - a developer
with model-making or graphic editing skills could take graphic pictures or even photos and arrange them into
letters in Blender or Gimp or Photoshop, InkScape, etc.
The code I wrote for this scans the font map images and automatically sets texture coordinates for each letter,
aligns them, applies padding for the second highlight/glow layer, etc...
My own game project is GPL v3, but if anyone wants some of these additions I've been working on to the
engine, or my own modifications I've made for the game, I would be willing to release those parts (not
specific to my game) under zlib license, same as the official Irrlicht engine.
NOTE: For those who look up this game on SourceForge, the code in the last download is very much out-ofdate, since then I've made lots of changes, including getting a working multi-threaded rendering system
working with the modified Irrlicht engine I'm using (It really works in my tests, and wasn't as hard as I
thought it would be!) and other stuff...
Here's the two pics, and as I said I would imagine a directx version would be easy to also put together:

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

5 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Image
...and...
Image
...Anyone interested?
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: Improved font rendering system.
by christianclavet » Wed Jun 25, 2014 5:03 pm
If you could extract the font rendering system so we could use it with a "vanilla" Irrlicht it would be really
nice. Since you create meshbuffers it could work in a new scene node.
Current projects:

http://irrrpgbuilder.sourceforge.net/
http://first-king.sourceforge.net

christianclavet
Posts: 1638
Joined: Mon Apr 30, 2007 3:24 am
Location: Montreal, CANADA
Website

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

6 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Top

Re: Improved font rendering system.
by Destructavator » Wed Jun 25, 2014 6:39 pm
christianclavet wrote:If you could extract the font rendering system so we could use it with a
"vanilla" Irrlicht it would be really nice. Since you create meshbuffers it could work in a new
scene node.

OK, sure, I can certainly do that.
I'd also like to mention, although it isn't shown in the example pics, that what I came up with also allows for
rotating the text to be angled away from the camera (like the opening intro text from nearly any "Star Wars"
film).
I'll put together a version for an unmodified Irrlicht, and also clean up my code just a little at the same time.
I'll also fix one small issue in my code, the fact that as it is coded right now in my own project, it reads the
image texture files, sets up the texture coordinates by scanning the images, etc. one time for each class
instance. I think it should really be just once per-font instead, so that if a developer uses the new class and has
multiple instances of the font being displayed, that the engine doesn't process duplicate jobs all over again in
setting up the font (if the texture images used are the same).
I already have a good idea of how to code this as such, I just have to get to work and do it.
One question: I can easily make all this happen for people that use the shader-pipeline branch, do you think
those who use the trunk branch in the SVN should have a version too? I think it *might* be possible to do it
in the trunk without shaders, although I'd have to do more research on the blending options for textures. Or, I
could just code it to use built-in hard-coded shaders (using text in strings, in C/C++ headers, so no external
shader data files would be needed). If I use a built-in shader approach I'd have to then include checks to make
sure the driver supports it of course, something I do know how to do and wouldn't be hard. Most graphics
cards that I know of for quite some time support at least basic, early version shaders, there might be a few
users with rather old machines that might get a warning or error message from the logger at runtime about
how their gfx card doesn't support any shaders at all for their driver. (I'm familiar with coding shaders that
use older versions of OpenGL, I wouldn't require anything fancy like the latest 4.x stuff for example, and
there's still plenty of guides for DirectX versions I'm sure I could figure it out.)
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

7 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Re: Improved font rendering system.
by Nadro » Wed Jun 25, 2014 8:02 pm
Shaders in trunk works the same as in shader-pipeline, shader-pipeline has support for flexible vertex format
and D3D11, but no other advantages over trunk yet. In trunk you can handle blending even easier than in
shader-pipeline - just set SMaterial::BlendOperation to something other than EBO_NONE and apply
blending factor to SMaterial::BlendFactor (those changes will be merged with shader-pipeline in future). You
don't need special material types for a blending.
Library helping with network requests, tasks management, logger etc in desktop and mobile apps:
https://github.com/GrupaPracuj/hermes
Nadro
Posts: 1648
Joined: Sun Feb 19, 2006 9:08 am
Location: Warsaw, Poland
Top

Re: Improved font rendering system.
by kklouzal » Thu Jun 26, 2014 3:38 am
Hey Nadro great work! Any progress on FreeType implementation? I have a request, that it be implemented
not as a part of the IGUIEnvironment (since some people compile Irrlicht without GUI but still require
2D/3D text rendering) but possibly as a part of the video driver? While we're on the subject what's the status
of Irrlicht 1.9 anyways? were a bit over the '6 months per release' timeframe, makes me excited to see all the
new improvements! ;)
Dream Big Or Go Home.
Help Me Help You.

kklouzal
Posts: 343
Joined: Sun Mar 28, 2010 8:14 pm
Location: USA - Arizona
Top

Re: Improved font rendering system.
by Nadro » Thu Jun 26, 2014 10:08 am
Currently I'm busy with tasks related to my game (I need ~2 weeks), so I don't have a time for Irrlicht tasks. 6
9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

8 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

months release cycle is a nice idea, but v1.9 has many new features + core devs daily tasks related to private
projects/job cause that we need more time for release v1.9. I think that you should ask CuteAlien about
FreeType implementation details and progress, but as I know he's busy with other tasks now.
Library helping with network requests, tasks management, logger etc in desktop and mobile apps:
https://github.com/GrupaPracuj/hermes
Nadro
Posts: 1648
Joined: Sun Feb 19, 2006 9:08 am
Location: Warsaw, Poland
Top

Re: Improved font rendering system.
by CuteAlien » Thu Jun 26, 2014 12:08 pm
My current solution is posted here: https://code.google.com/p/irr-playgroun ... ce/browse/ (the CGUITTFont
files + gui_font.cpp). Just copy those files into your project. It's not ready yet for Irrlicht and I won't get to
working on it more anytime soon I fear (I had to take on a non-Irrlicht project for living and won't be around
the next 2 months).
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Improved font rendering system.
by FloatyBoaty » Thu Sep 11, 2014 4:28 pm
My contribution: scalable bitmap font
CGUIFontBitmapScalable.h: http://ideone.com/iXGHGQ
--------------------------------------------CGUIFontBitmapScalable.cpp: http://ideone.com/arAeu6
------------------------------------------

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

9 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

example use:
cpp Code: Select all
irr::gui::CGUIFontBitmapScalable* BaseApplication::loadFont(irr::io::path
relative)
{
#ifdef _IRR_COMPILE_WITH_GUI_
// check if already loaded
irr::gui::CGUIFontBitmapScalable* font = NULL;
irr::core::map<irr::io::path, irr::gui::CGUIFontBitmapScalable*>::Node* node
= scalableFonts.find(relative);
if(node) font = node->getValue();
else font = new irr::gui::CGUIFontBitmapScalable(iGui, relative, iLogger); //
not already loaded
if(font->load(getBaseAssetDir() + relative)) return getCheckedFont(relative,
font);
else
{
irr::io::path xml = getBaseAssetDir() + relative;
irr::u32 di = xml.findLast('/') + 1;
irr::io::path imageDir = xml.subString(0, di);
irr::io::IXMLReader* xRead = iFileSystem->createXMLReader(xml);
if(xRead && font->load(xRead, imageDir))
{
xRead->drop();
return getCheckedFont(relative, font);
}
}
irr::core::string<irr::c8> err = "Font not loaded: ";
err.append(getBaseAssetDir() + relative);
iLogger->log(err.c_str(), irr::ELL_ERROR);
delete font;
#endif // _IRR_COMPILE_WITH_GUI_
return NULL;
}
#ifdef _IRR_COMPILE_WITH_GUI_
irr::gui::CGUIFontBitmapScalable* BaseApplication::getCheckedFont(irr::io::path
relative, irr::gui::CGUIFontBitmapScalable* font)
{
irr::gui::IGUIFont* testFont = iGui->addFont(relative, font);
irr::gui::CGUIFontBitmapScalable* fontResizable =
dynamic_cast<irr::gui::CGUIFontBitmapScalable*>(testFont);
if(!fontResizable)
{
iGui->removeFont(testFont);
fontResizable =
(irr::gui::CGUIFontBitmapScalable*)iGui->addFont(relative, font);

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

10 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

}
scalableFonts.insert(relative, fontResizable);
return fontResizable;
}
#endif // _IRR_COMPILE_WITH_GUI_
irr::io::path BaseApplication::getBaseAssetDir()
{
#ifdef _IRR_ANDROID_PLATFORM_
return "";
#else
return "assets/";
#endif // _IRR_ANDROID_PLATFORM_
}

FloatyBoaty
Posts: 32
Joined: Thu Aug 21, 2014 11:39 pm
Top

Re: Improved font rendering system.
by CuteAlien » Mon Sep 15, 2014 10:27 am
@FloatyBoaty: For some reason (which we haven't found so far) the forum only shows empty posts when too
much code is posted in code tags. So I've moved parts of your code to ideone, so people can see it. I hope you
are fine with that.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top
PreviousNext Display posts from previous:

Sort by

Post a reply
34 posts • Page 2 of 3 • 1, 2, 3

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Improved font rendering system.

11 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=2&t=49021&start=15

Return to Open Discussion and Dev Announcements
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:57 PM

Irrlicht Engine • View topic - Joint control and animation transitioning n...

1 of 3

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=47579

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Beginners Help
Change font size
Print view
FAQ
Register
Login

Joint control and animation transitioning not working
Post a reply

4 posts • Page 1 of 1

Joint control and animation transitioning not working
by MirceaKitsune » Thu Nov 08, 2012 11:56 pm
Hello there. I'm working on an open-source project using the Irrlicht engine, and took the initiative of implementing 3D model support (with object to object attachments). It's meant to work with animated skeletal models, which are used under the x
format (created and exported from Blender). I can properly set the mesh on an IAnimatedMeshSceneNode and loop animations using setFrameLoop(start, end). However, I'm having serious issues when it comes preforming special tasks with skeletal
bones / joints of the mesh.
The issue is that when I try to enable individual control of joints or animation blending, it doesn't work. It will also cause animations to no longer play (stay at frame 1 I believe) and oddly enough, the normals of the mesh get inverted and its surface
shows inside-out. On the topic of bone control, I need to be able to manually override the rotation of individual bones without affecting other bones and the current animation. For example, to have a character's head looking up or down depending on
where the player is looking, but without interfering with the walk / run / stand / etc animation playing on that model (just take control of the head joint). I hope that is possible in Irrlicht at this day.
What I'm currently trying is: First of all I read I must enable some flags on the node. For animation blending (setTransitionTime(speed)) I need to set node->animateJoints() which I'm doing after I create the node. This works and causes no issues.
However, setting animation transitioning time to anything other than 0 causes the error I mentioned. Next, to manually override joint position / rotation, I heard I must do node->setJointMode(irr::scene::EJUOR_CONTROL) first. If I enable this
however, I once again get the same issue. I would later get the bone using irr::scene::IBoneSceneNode* bone = node->getJointNode(bone_name) and change position and rotation via bone->setPosition and bone->setRotation... but due to the problem I
don't get to this point yet.
Why does enabling skeletal control or animation transitioning on animated mesh nodes not work and cause animations to stop working at all? Is it an issue with the x mesh format, or the native Blender exporter for it? Or is it a known Irrlicht bug or
another flag I'm forgetting?
MirceaKitsune
Posts: 9
Joined: Thu Nov 08, 2012 10:49 pm
Top

Re: Joint control and animation transitioning not working
by MirceaKitsune » Wed Nov 14, 2012 1:42 pm
I did more tests on this today. It appears that using setJointMode(irr::scene::EJUOR_CONTROL) then modifying the position / rotation of a bone does work properly itself. But it also causes animations to break and mesh normals to get inverted. It
also makes children parented to a bone of that parent to go to origin 0,0,0.
Here are two screenshots of the project where I'm using this. In the first screenshot, I don't use EJUOR_CONTROL and both meshes work fine attached to each other. In the second screenshot, EJUOR_CONTROL is enabled, causing them to no
longer animate and the model to show inside-out (the stretch is normal as I offset one of the joints in my test, that part works). Any help on this would be appreciated.
Image

9/6/2019, 4:02 PM

Irrlicht Engine • View topic - Joint control and animation transitioning n...

2 of 3

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=47579

MirceaKitsune
Posts: 9
Joined: Thu Nov 08, 2012 10:49 pm
Top

Re: Joint control and animation transitioning not working
by Destructavator » Wed Nov 14, 2012 11:36 pm
I'm wondering if it might be related to this little proposed fix (suggested by another forum member), which might or might not have made it into the version 1.8 release of the SDK:
http://irrlicht.sourceforge.net/forum/viewtopic.php?f=7&t=47041
I also play with SVN checkouts of Irrlicht, and usually I read the SVN logs, but I can't recall if the developers ever included the fix (or something based upon it) or not.
I don't have time right now to pull up the 1.8 release source I downloaded and check myself, but I hope this info helps.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI, Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos, decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: Joint control and animation transitioning not working
by hybrid » Wed Nov 14, 2012 11:54 pm
Well, I wrote that it will be postponed to a later 1.8.x release, so no, won't be in the 1.8 release.
hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top
Display posts from previous:

Sort by

Post a reply
4 posts • Page 1 of 1
Return to Beginners Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index

9/6/2019, 4:02 PM

Irrlicht Engine • View topic - Joint control and animation transitioning n...

3 of 3

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=47579

The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 4:02 PM

Irrlicht Engine • View topic - Newb C++ issue

1 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Beginners Help
Change font size
Print view
FAQ
Register
Login

Newb C++ issue
Post a reply

7 posts • Page 1 of 1

Newb C++ issue
by darksmaster923 » Mon Mar 21, 2011 11:42 pm
Alright, so I finally started to actually start learning C++ and irrlicht seriously. I'm tinkering around with
irrlicht, and I'm coming up with what looks like to be a C++ code error, where it says "Unhandled exception
at 0x00be1c24 in irrlicht.exe: 0xC0000005: Access violation reading location 0xcccccccc." when I exit the
program, and graphics says
Code: Select all
irr::IReferenceCounted

CXX0030: Error: expression cannot be evaluated

Heres my code
init.h

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

2 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

Code: Select all
#include "irrlicht.h"
#include "driverChoice.h"
#include "iostream"

class initGame
{
public:
initGame();
int CreateDevice();
void StartGame();
irr::IrrlichtDevice *graphics;
float time;
};

init.cpp
Code: Select all
#include "StdAfx.h"
#include "init.h"
using namespace irr;
using namespace std;
#ifdef _IRR_WINDOWS_
#pragma comment(lib, "Irrlicht.lib")
#pragma comment(linker, "/subsystem:windows /ENTRY:mainCRTStartup")
#endif

int main()
{
initGame Init;
initGame();
Init.CreateDevice();
Init.StartGame();
return 0;

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

3 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

}
initGame::initGame()
{
}
void initGame::StartGame()
{
graphics->setWindowCaption(L"SAFSSDFSDFS");
}
int initGame::CreateDevice()
{
video::E_DRIVER_TYPE driverType;
IrrlichtDevice *graphics = createDevice(video::EDT_DIRECT3D9,
core::dimension2d<u32>(1024,768),32,false,true,false,0);
/*
if(!graphics)
{
return 1;
//returns 1
}
*/
//KeyListener receiver;
graphics->setWindowCaption(L"Test");
video::IVideoDriver *driver=graphics->getVideoDriver();
scene::ISceneManager *smgr=graphics->getSceneManager();
gui::IGUIEnvironment* gui=graphics->getGUIEnvironment();
gui::IGUISkin* skin = gui->getSkin();
gui::IGUIFont* font = gui->getFont("../../media/fonthaettenschweiler.bmp");

while(graphics->run())
{
//core::vector3df playerposition=playercam->getAbsolutePosition();

driver->beginScene(true, true, video::SColor(255,20,20,100));
smgr->drawAll();
gui->drawAll();
driver->endScene();
}
graphics->drop();

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

4 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

return 0;
}

thanks in advance
Programmers are merely tools to convert caffeine into code.
darksmaster923
Posts: 51
Joined: Tue Jan 02, 2007 11:04 pm
Location: huntington beach
Top
by ChaiRuiPeng » Mon Mar 21, 2011 11:54 pm
i put in comments. one of your biggest errors was calling the constructor explicitly.
you dont do that. an objects constructor gets called auto when it is created.
Code: Select all
#include <irrlicht.h>
#include "driverChoice.h"
#include "iostream"

class initGame
{
public:

initGame();
int CreateDevice();
void StartGame();
irr::IrrlichtDevice* graphics;
float time;

};

Code: Select all

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

5 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

#include "StdAfx.h"
#include "init.h"
using namespace irr;
using namespace std;
#ifdef _IRR_WINDOWS_
#pragma comment(lib, "Irrlicht.lib")
#pragma comment(linker, "/subsystem:windows /ENTRY:mainCRTStartup")
#endif

int main()
{
initGame Init;
initGame(); //you do not explicitly call the constructor ;)
Init.CreateDevice();
Init.StartGame();
return 0;
}
initGame::initGame():graphics(0), time(0.f) //this is an initializer list
{
}
void initGame::StartGame()
{
graphics->setWindowCaption(L"SAFSSDFSDFS");
}
int initGame::CreateDevice()
{
video::E_DRIVER_TYPE driverType; //what is this for?
//you dont need to declare a second one
graphics = createDevice(video::EDT_DIRECT3D9, core::dimension2d<u32>
(1024,768),32,false,true,false,0);

if(!graphics)
{
return 1;
}

//you dont really need this comment :P
//returns 1

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

6 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

//KeyListener receiver;
graphics->setWindowCaption(L"Test");
video::IVideoDriver *driver=graphics->getVideoDriver();
scene::ISceneManager *smgr=graphics->getSceneManager();
gui::IGUIEnvironment* gui=graphics->getGUIEnvironment();
gui::IGUISkin* skin = gui->getSkin();
gui::IGUIFont* font = gui->getFont("../../media/fonthaettenschweiler.bmp");

while(graphics->run())
{
//core::vector3df playerposition=playercam->getAbsolutePosition();

driver->beginScene(true, true, video::SColor(255,20,20,100));
smgr->drawAll();
gui->drawAll();
driver->endScene();
}
graphics->drop();

return 0;
}

EDIT: also i dont see why you call createDevice() and THEN startGame()
seeing there is a while loop in createDevice() wouldnt it make mroe sense to createDevice(), and then have
the while loop in startGame?
ent1ty wrote:success is a matter of concentration and desire

Butler Lampson wrote: all problems in Computer Science can be solved by another level of
indirection
at a cost measure in computer resources

ChaiRuiPeng

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

7 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

Posts: 363
Joined: Thu Dec 16, 2010 8:50 pm
Location: Somewhere in the clouds.. drinking pink lemonade and sunshine..
Top

Re: Newb C++ issue
by hayate » Tue Mar 22, 2011 12:02 am
darksmaster923 wrote:
Code: Select all
int main()
{
initGame Init;
initGame();
Init.CreateDevice(); <------------ PROBLEM HERE
Init.StartGame(); <--------------- PROBLEM HERE
return 0;
}
void initGame::StartGame()
{
graphics->setWindowCaption(L"SAFSSDFSDFS");
}
int initGame::CreateDevice()
{
video::E_DRIVER_TYPE driverType;
IrrlichtDevice *graphics = createDevice(video::EDT_DIRECT3D9,
core::dimension2d<u32>(1024,768),32,false,true,false,0);
/*
if(!graphics)
{
return 1;
//returns 1
}
*/
while(graphics->run())
{
}
graphics->drop();

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

8 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

return 0;
}

You call graphics->setWindowCaption(L"SAFSSDFSDFS"); in StartGame() but the Irrlicht Device
"graphics" has been deleted at the end of CreateDevice()
I also suggest to not put the rendering loop in CreateDevice()
Sorry for my awful english ^_^'
Image
User avatar
hayate
Posts: 43
Joined: Mon Feb 16, 2009 9:38 pm
Location: Brescia, Italy
Top
by darksmaster923 » Tue Mar 22, 2011 1:21 am
I thought that referencing it in the header file would let it 'survive' across multiple functions? Like a global
variable?
darksmaster923
Posts: 51
Joined: Tue Jan 02, 2007 11:04 pm
Location: huntington beach
Top
by Destructavator » Tue Mar 22, 2011 1:26 am
If you haven't already, I'd strongly suggest taking one of the tutorial demos and trying to modify it, rather
than starting from scratch.
If you really want to work with an example that is broken into multiple files, instead of having everything
slammed into one main.cpp - which is what most of the tutorials do, and isn't how most real programs are laid
out in C++ - I'd suggest going through the TechDemo example, one of the last ones in the tutorial list IIRC. It
uses multiple files, has a config menu that comes up before the actual "game" starts, and in other ways is
closer to a real game compared to, say, the first "Hello World" program.
If you can add to or change things in that Tech Demo and make the changes/additions work (start by
changing just a few lines here and there to see the results), that might be an easier starting point compared to
writing a lot of lines of code from scratch and not knowing which ones or how many lines are causing a

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

9 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

problem.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
by Radikalizm » Tue Mar 22, 2011 1:35 am
You're calling graphics->drop() at the end of your createDevice() function (which is kind of weird if you
think about it), this will bring the object's reference count down to 0 which will cause it to get deleted
So now you have an invalid object reference which you try to use in your startGame() function, causing
unwanted and undefined behaviour
It might be a good idea to read up on some tutorials about pointers, they can be pretty intimidating when
you're new to C++, but they are a crucial part of the language
Also, to avoid confusion, try to keep the name of a function linked to the actual working of a function, a
function called createDevice() should not contain a drawing loop and should definitely not destroy the
created device right before returning
Image
The RainWare blog: General ramblings by the RainWare devs about latest projects and game dev!
So you want to write a game: A beginners guide to game programming
Radikalizm
Posts: 1215
Joined: Tue Jan 09, 2007 7:03 pm
Location: Leuven, Belgium
Top
by Destructavator » Tue Mar 22, 2011 1:37 am
darksmaster923 wrote:I thought that referencing it in the header file would let it 'survive' across
multiple functions? Like a global variable?

No, in this case, the way you wrote it out, it does not "survive" quite like what I think you want.

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

10 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

Looking at:
Code: Select all
IrrlichtDevice *graphics = createDevice(video::EDT_DIRECT3D9,
core::dimension2d<u32>(1024,768),32,false,true,false,0);
/*
if(!graphics)
{
return 1;
//returns 1
}
*/
while(graphics->run())
{
}
graphics->drop();

The whole "game" runs from the "while" until it gets terminated, interrupted, runs into an error, or for some
reason the device no longer "runs" and is stopped. It then "drops" the device, which sorta kills it and ends
your program.
Your main game loop goes between the brackets in that "while" statement, which is where you start a scene,
draw stuff, end the scene, and let it repeat. Right now it is empty.
For a simple game you could just have another class with all your main game loop stuff, and call some
function that draws and does everything you want to happen while the game runs, inside that "while"
statement.
Example:
Code: Select all
while(graphics->run())
{
Game->Run(); // Most of your game goes here!
}

Of course you'd have to write more files and code to define the class "Game", and of course don't forget to
create an instance of it before the while statement comes up and you start calling that Game::Run() function.
EDIT: Radikalizm posted at the same time I did, and probably explained a few things better than I could.
Like I said, try mucking around with one of the already-written tutorial demos, and see if you can "read" the
code and figure out why things are located where they are in what parts of the code.

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - Newb C++ issue

11 of 11

http://irrlicht.sourceforge.net/forum/viewtopic.php?t=43403

EDIT (2): Whoops! I mis-read parts of the thread, and forgot already some of the stuff you had in the original
post already. I'm an idiot! (Actually, part of the issue is I'm running on three hours of sleep, after an allnighter the night right before.) Sorry, it looks like only some of what I posted applies.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
Display posts from previous:

Sort by

Post a reply
7 posts • Page 1 of 1
Return to Beginners Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:56 PM

Irrlicht Engine • View topic - SDL2 + Irrlicht

1 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=49980&p=28...

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Beginners Help
Change font size
Print view
FAQ
Register
Login

SDL2 + Irrlicht
Post a reply

4 posts • Page 1 of 1

SDL2 + Irrlicht
by stefany » Mon Jun 16, 2014 11:34 am
Hi, i am having problems with SDL2 under linux. In windows 8.1 runs perfectly. But i can only integrate
SDL2 and irrlicht in Debian when irrlicht is compiled in debug mode.
In release mode i get
cpp Code: Select all
Major opcode of failed request: 154 (GLX)
Minor opcode of failed request: 31 (X_GLXCreateWindow)
Serial number of failed request: 26
Current serial number in output stream: 30

And the program ends.

9/6/2019, 3:54 PM

Irrlicht Engine • View topic - SDL2 + Irrlicht

2 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=49980&p=28...

And in debug mode, i get an error, but all works:
cpp Code: Select all
X Error: GLXBadWindow
From call : unknown

My integration code with SDL is basically this:
cpp Code: Select all
int flags = SDL_WINDOW_OPENGL | SDL_WINDOW_ALLOW_HIGHDPI | SDL_WINDOW_BORDERLESS;
if(mUserConfig && mUserConfig->video.fullScreen)
flags = SDL_WINDOW_FULLSCREEN;
mSDLWindow = SDL_CreateWindow("SE",
SDL_WINDOWPOS_CENTERED,
SDL_WINDOWPOS_CENTERED,
(mUserConfig != nullptr) ?
mUserConfig->video.size.Width : 500,
(mUserConfig != nullptr) ?
mUserConfig->video.size.Height : 500,
flags);

if(mSDLWindow) {
//SDL_GLContext context = SDL_GL_CreateContext(mSDLWindow);
irr::SIrrlichtCreationParameters creationParams;
creationParams.DriverType = irr::video::EDT_OPENGL;
creationParams.Fullscreen = false;
creationParams.AntiAlias = true;
creationParams.Bits = 32;
creationParams.Vsync = (mUserConfig) ? mUserConfig->video.vsync : true;
SDL_SysWMinfo info;
SDL_VERSION(&info.version);
if(SDL_GetWindowWMInfo(mSDLWindow, &info))
{
#ifdef _IRR_WINDOWS_
creationParams.WindowId = reinterpret_cast<void *>(info.info.win.window);
#else
creationParams.IgnoreInput=true;
creationParams.WindowId = reinterpret_cast<void *>(info.info.x11.window);
#endif
mIrrDevice = irr::createDeviceEx(creationParams);
}
else

9/6/2019, 3:54 PM

Irrlicht Engine • View topic - SDL2 + Irrlicht

3 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=49980&p=28...

SE_END_PROGRAM("SDL failed to get the driver dependient windows information")
}

Have a nice day!
stefany
Posts: 58
Joined: Wed Dec 07, 2011 10:50 am
Top

Re: SDL2 + Irrlicht
by Destructavator » Sun Jun 22, 2014 10:36 pm
Not sure how helpful this is, but as I understand it a desktop window (that one might want to create an
OpenGL context within, and from glancing at your code it looks like you are going for OpenGL) is very
different between Linux and Microsoft Windows OS. The methods for creating an OpenGL context are not
the same. MS Windows, by itself, has very spartan support for OpenGL (other than a simple, rinky-dink
software-driven support) that doesn't go past version 1.1 IIRC and needs "extensions" for hardwareaccelarated OpenGL and modern features. I've looked at SDL2 code recently, and they have a customized
version of the extension header file "glext.h" which is re-named with a "SDL_" prefix (The official header
can be downloaded freely from the OpenGL website). SDL2 has a system which can intelligently auto-detect
if the official glext.h header is used or not, and adjust itself to use or not use its own internal version. This
might be part of why on Windows 8.1 the system can adjust and make itself work OK.
As for Linux, I'm just starting to get into how OpenGL is done on that platform, I know it doesn't use the
same header files at all (the glext.h or the wiggle extension header that windows needs) and I haven't looked
at how SDL2 does it yet, but the only thing I can *guess* here is that perhaps in debug mode your code on
Debian is doing extra checks / corrections that it might not do otherwise, perhaps correcting for some issue
which will still need to be fixed to do what you want.
Again, I don't know if any of that helps, perhaps you can sift through that and pick out a snippet of something
useful that might help you. My own knowledge of programming on Linux is not the best, something I'm still
trying to develop myself.
Hopefully someone here who knows Linux better than I do can give a better and more clear answer.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm

9/6/2019, 3:54 PM

Irrlicht Engine • View topic - SDL2 + Irrlicht

4 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=49980&p=28...

Location: Ohio, USA
Top

Re: SDL2 + Irrlicht
by FloatyBoaty » Fri Sep 19, 2014 9:37 pm
I just finished an SDL2 driver port, but assets do not load on Android.
However, according to SDL, they exist...
Any help?
Here's the diff:
http://pastebin.com/0qTTxDaA
FloatyBoaty
Posts: 32
Joined: Thu Aug 21, 2014 11:39 pm
Top

Re: SDL2 + Irrlicht
by FloatyBoaty » Sat Sep 20, 2014 7:53 pm
it was the ogles shader path....
http://pastebin.com/0qTTxDaA
FloatyBoaty
Posts: 32
Joined: Thu Aug 21, 2014 11:39 pm
Top
Display posts from previous:

Sort by

Post a reply
4 posts • Page 1 of 1
Return to Beginners Help
Jump to:

Who is online

9/6/2019, 3:54 PM

Irrlicht Engine • View topic - SDL2 + Irrlicht

5 of 5

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=49980&p=28...

Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 3:54 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

1 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Irrlicht Help ‹ Beginners Help
Change font size
Print view
FAQ
Register
Login

SOLVED-Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
Post a reply

11 posts • Page 1 of 1

SOLVED-Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by nightrobin » Tue Jun 24, 2014 11:19 am
Good day,
I just want to ask for help in setting up my Codeblocks 13.12 (with CodeBlocks' own MinGW) with Irrlicht
1.8.1, I can't seem to find any useful information/tutorial about it.
And the default Irrlicht Project in Codeblocks seems outdated and not running.
Also I want to know how to set this up manually and step by step.
I have windows 7.
Thanks in advance
Last edited by nightrobin on Wed Jun 25, 2014 10:14 am, edited 2 times in total.
nightrobin
Posts: 5
Joined: Tue Jun 24, 2014 11:12 am
9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

2 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by CuteAlien » Tue Jun 24, 2014 12:57 pm
Sorry, I thought we had that in the wiki, but can't find it. But I didn't hear about the project beeing outdated can you please post the exact errors which you get? We can probably help you then.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by nightrobin » Tue Jun 24, 2014 1:03 pm
CuteAlien wrote:Sorry, I thought we had that in the wiki, but can't find it. But I didn't hear about
the project beeing outdated - can you please post the exact errors which you get? We can
probably help you then.

The Error Screenshot is here:
http://1drv.ms/1jcDdIA
(I can't upload a picture so I just put a link)
nightrobin
Posts: 5
Joined: Tue Jun 24, 2014 11:12 am
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by hybrid » Tue Jun 24, 2014 3:21 pm

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

3 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

I think we had those things before already, but any google hit shoudl have helped. Take this one:
https://stackoverflow.com/questions/329 ... ity-v0-for
Simply said, you have to use g++ instead of gcc to link, or set up some other compilation flags instead. Most
of them are in the example project files, which should work out of the box. So if you just copy those to your
own enviroment you should be fine as well.
hybrid
Admin
Posts: 14143
Joined: Wed Apr 19, 2006 9:20 pm
Location: Oldenburg(Oldb), Germany
Website
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by CuteAlien » Tue Jun 24, 2014 4:16 pm
Also on C::B on Windows it often helps to re-compile the Irrlicht dll (the corresponding project file is in
source/Irrlicht). The problem is that there are different g++ versions out there for MinGW which are not
compatible to each other. Not sure if that could also cause this specific error.
IRC: #irrlicht on irc.freenode.net
Code snippets, patches&stuff: http://www.michaelzeilfelder.de/irrlicht.htm
Free racer created with Irrlicht: http://www.irrgheist.com/hcraftsource.htm

CuteAlien
Admin
Posts: 8810
Joined: Mon Mar 06, 2006 2:25 pm
Location: Tübingen, Germany
Website
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by Destructavator » Tue Jun 24, 2014 5:00 pm
Hi, a C::B (Codeblocks) IDE + MinGW + Irrlicht setup is *exactly* what I work with, so I might be of some
assistance here.
I also work with multiple versions and variants of MinGW, so I'm familiar with the differences between some
of the versions (but not absolutely all of them, lots of variants are out there and I can't say I've tried every
single one).

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

4 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

I would *strongly* recommend using one of the TDM (twilight media dragon) builds of MinGW, not only is
it a popular one that is one of the more widely used MinGW packages, but it is one of the easiest to set up
and get going with the minimum amount of pain, it supports both a host and platform target of your choice of
32 or 64 bit Windows (meaning that the build environment can be set up and can compile on a 32 or 64 bit
Windows machine, and in both situations can build programs targets to run on your choice of 32 or 64 bit
Windows, so as such the package is more technically known as a "multi-lib" version). I actually heard recent
word direct from the package maintainer / author that he is working on getting a new version out based upon
MinGW 4.9.x specs, but until then the build for 4.8.1 is very much rock-solid stable, very reliable, and still
modern and current enough for most purposes.
The TDM builds of MinGW are also available on SourceForge, getting the most recent package is very easy
with SF's search engine.
Last time I checked the download for C::B IDE can include a TDM build of MinGW, although IIRC the
included version is out of date, based upon a 4.7.x build.
Also last time I checked, Irrlicht compiles right out-of-the-box with C::B and MinGW (the recent 4.8.1-based
version) with the supplied C::B project and workspace files in the trunk branch of the SVN repo for Irrlicht. I
would *think* that this would also apply to the last official release of Irrlicht from the SourceForge download
section for the project.
Of course, re-compiling the Irrlicht DLL and the included tutorial projects with such a setup and having it
work right assumes that you set up the compiler's .exe files in the proper places in the C::B compiler
configuration. If you need help with this, if this is where you are stuck, I'd suggest:
1) Look at the pre-set configuration for standard, old-fasioned 32-bit regular builds of MinGW (which I don't
recommend using for a number of reasons). From the main screen of C::B, go to "Settings" then
"Compiler...", and you should see the pre-set configuration for "GNU GCC Compiler" already chosen as the
first choice to change configuration settings for. Then go to the "Toolchain Execuatables" tab. Note the name
of the .exe files for each component, such as "gcc.exe" for C files, "g++.exe" for C++ files, etc. In some cases
the pre-set configuration may have filenames prefixed with various different things, so you might see
something like "mingw32-gcc.exe" for compiling C files, etc.
2) Once you have an updated version of MinGW, the branch of your choice, you want to either (A) Copy the
settings for GNU GCC Compiler and alter the duplicate to work with the new MinGW copy, or (B) just
change the existing GCC compiler configuration. When done, it should have the working top-level folder /
directory where MinGW is installed (the version you use, of course), not the "bin" directory inside it, but
right one step outside of that folder, the path wherever you set up MinGW. You can then use the "..." buttons
to automatically open a file browser window where you want to pick the .exe files with similar or matching
names, to set up proper compiling, linking, etc.
3) If you still need any help at this stage, just say so and I'll post screen shots.
BTW, the TDM builds of MinGW are very powerful, highly optimized and can potentially build very
efficient code. The 64-bit options, based upon the MinGW-w64 project, are especially slick, and are really
intelligent in automatically generating optimized machine code when configured properly, code which in
some independent tests that I've seen can often compare roughly equal / comparable to Microsoft compilers,
sometimes even faster depending on what the code is exactly. Of course, this also greatly depends on your
skill at coding to use that potential properly.
The TDM builds also have full support for LTO (Link-Time Optimization), which indeed does work with
projects using Irrlicht (just don't try to use such compiler options on the Irrlicht DLL itself, but only projects

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

5 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

which import the DLL and use it). You might also be pleased to know that the TDM builds of MinGW also
fully support an updated implementation of OpenMP, which allows for very easy and pain-free multithreading programming. In my own tests, Irrlicht-based games and projects work with OpenMP (libgomp)
quite nicely, so if you learn OpenMP you can easily have a multi-threaded main loop in your game that uses
all of an end-users computer cores, and automatically adjusts itself depending on whomever runs your final
demo / game / program, if you make something you want to distribute to others.
If you have any specific questions on anything I've mentioned, or how to set up or use any of those features,
just ask.
EDIT: Please also note, that by default re-compiling the Irrlicht DLL with such a setup doesn't include
support for DirectX-based graphics, which means you can either (A) Go with OpenGL, which is crossplatform anyways, or (B) Go through a few extra steps to re-build Irrlicht with full DirectX support (requires
some extra downloads from MS, and fiddling with the irrCompileConfig.h header "#define" statements).
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by AReichl » Wed Jun 25, 2014 8:14 am
hmmm - with MinGW-TDM i cannot compile some examples from Irrlicht.
I tried a lot of MinGW "distributions", but the most feature complete and problem free (for me) is:
http://sourceforge.net/projects/mingw-w ... gw-builds/
Best use "threads-posix" and then "sjlj".
AReichl
Posts: 258
Joined: Wed Jul 13, 2011 2:34 pm
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by nightrobin » Wed Jun 25, 2014 10:12 am

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

6 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

Thanks for all the help you gave, it solved the problem after I compile it
nightrobin
Posts: 5
Joined: Tue Jun 24, 2014 11:12 am
Top

Re: Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by Destructavator » Wed Jun 25, 2014 2:21 pm
AReichl wrote:hmmm - with MinGW-TDM i cannot compile some examples from Irrlicht.
I tried a lot of MinGW "distributions", but the most feature complete and problem free (for me)
is:
http://sourceforge.net/projects/mingw-w ... gw-builds/
Best use "threads-posix" and then "sjlj".

Hmmm.... That's strange, as the last time I recall building Irrlicht and the examples (first the DLL, then the
projects), I don't remember having any issues (with TDM). I'm not saying I don't believe you though, part of
it might be that with the copy of Irrlicht I use I've modified the source of the Irrlicht engine here and there for
my own project's purposes. I also haven't played with the regular, unmodified engine code or examples for a
while now, it is possible something may have changed since I last did that.
As for the link you gave, yes, I'm familiar with that one too, I've used the "mingw-builds" distributions
before, I remember when they were an independent SF project. Their distributions are also (usually) good,
although some releases have bugs that have to be worked around, so in downloading one of their builds the
results of using them can be hit or miss. Most of their builds do get the job done, though, and the only real
reason some builds work better than others is that they seem to maintain a goal of trying to always keep up
with the latest bleeding-edge versions of components. Yes, some of their releases are very powerful, and yes,
they pack lots of enabled features in - Some of their 64-bit releases using SEH are especially fast - though for
programmers who have limited experience and especially beginners, I often recommend TDM simply
because although it might not always be bleeding edge, the TDM package author / maintainer puts a lot of
work into making sure that nearly every release is very stable and reliable, working more for a rock-solid
release with emphasis on consistent reliability, even if the components are not always the very latest
bleeding-edge versions. For someone who really knows what they are doing though, and how to deal with
compiler bug issues when they come up, I have nothing against the "mingw-builds" versions.
I still have an SVN client and local copy of the Irrlicht repo on this machine, Just out of curiosity I'll try to rebuild the official code projects and see if there's something that should potentially be put on the bugtracker.
Sometime today I'll try to do the same with the last stable release download on SF.
BTW, you *did* try to rebuild the Irrlicht DLL first, before the example projects, yes?
@nightrobin: Glad you got it working! If you need more help later down the road, just ask. Also, if you do
9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

7 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

happen to use a TDM build (in some cases this also applies to other MinGW builds too), don't forget to read
up on the "-m32" and "-m64" switches for controlling if you are building a project intended to run on a target
machine running 32 or 64 bit OS. (They need to be sent to *both* the compiler *and* the linker. Many
MinGW builds will automatically pick one if you don't specify, which is usually fine when you try out and
test code on your own machine, but be aware of how they work if you make something you want to distribute
to other people.)
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: SOLVED-Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by AReichl » Wed Jun 25, 2014 3:45 pm
I don't want to hijack this thread, but ...
With MinGW-TDM example 16 Quake 3 Map Shader would not link ( problem with snprintf ).
On the other side example 21 Quake 3 Explorer ( which also uses snprintf ) compiles and links fine.
I found if i put
#include "driverChoice.h"
ABOVE !!!
#include <irrlicht.h>
it works.
But still - this and other problems with other libraries ( Irrklang, Bullet, Boost, POCO, ... ) i don't have with
the distribution i use.
AReichl
Posts: 258
Joined: Wed Jul 13, 2011 2:34 pm
Top

Re: SOLVED-Help in CodeBlocks 13.12 and Irrlicht 1.8.1 Setup
by Destructavator » Wed Jun 25, 2014 4:06 pm
AReichl wrote:I don't want to hijack this thread, but ...

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

8 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

With MinGW-TDM example 16 Quake 3 Map Shader would not link ( problem with snprintf ).
On the other side example 21 Quake 3 Explorer ( which also uses snprintf ) compiles and links
fine.
I found if i put
#include "driverChoice.h"
ABOVE !!!
#include <irrlicht.h>
it works.
But still - this and other problems with other libraries ( Irrklang, Bullet, Boost, POCO, ... ) i don't
have with the distribution i use.

I can't reproduce the error you mentioned, at least with the latest SVN version 4898, trunk.
I used a fresh SVN checkout, and just opened up the existing workspace in the examples folder.
I had no global switches or special settings sent to the compiler, linker, or anything else, just used out-of-thebox MinGW TDM 4.8.1-3 download, everything default all across the board. (TDM MinGW, by default, will
include needed libraries in a static fashion, c++ as well as anything else used, another reason I recommend it
to people new to MinGW. Because I didn't add any command-line switches in this case, this also means that
"-m64" is implied by default, so in my quick test I'm actually building 64-bit binaries and a 64-bit Irrlicht
DLL, but I still wanted to test with everything out-of-the-box and no special configuration set.)
- Irrlicht DLL built just fine, lots of warnings about trying to build without RTTI when compiling the C files
for the dependencies, but those are no big deal. I chose "Win32 - accurate math - release - DLL" No errors.
- Built and ran the first four examples, choosing "Windows" for the target of course. No errors, the examples
ran just fine.
- Built and ran both examples 16 and 21 you mentioned, both built and ran just fine. No errors, didn't have
the issues you mentioned, didn't touch the source code.
- Built the tech demo project. Compiled and linked just fine, just a warning about an unrecognized #pragma
statement meant for MSVC compilers (which is no big deal, shouldn't hurt the program). Ran it, no errors.
The runtime log did spit out a warning about how an image texture had to be resized, because the source was
in oddball dimensions, uneven and not power-of-two, so it made it 128x128, but still used it.
Again, this is with everything out-of-the-box, as if I had just installed everything and didn't change the global
compiler settings, didn't add any switches or change any options in C::B. I also didn't touch the
irrCompileConfig.h header.
I'm not sure where your problems are coming from, I don't know why you are having a different result.
I admit I didn't do this with the latest official release download from SourceForge, just the most recent SVN
checkout. As such, it is possible there may have been some bugs that were fixed since the last release that
made the difference in this case.
EDIT: I also didn't try this test with the shader-pipeline branch - Is that what you're using?

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - SOLVED-Help in CodeBlocks 13.12 and Ir...

9 of 9

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=1&t=50008

EDIT (2): Perhaps we should have another thread for this, one where we discuss Irrlicht with various versions
of MinGW and talk about trying to figure out why / how some people are getting inconsistent results.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top
Display posts from previous:

Sort by

Post a reply
11 posts • Page 1 of 1
Return to Beginners Help
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 4:01 PM

Irrlicht Engine • View topic - "Tribal Creature of the Sky" (Help apprecia...

1 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=6&t=48321

Irrlicht Engine
Official forum of the Irrlicht Engine
Skip to content

Advanced search
Board index ‹ Other Irrlicht Stuff ‹ Project Announcements
Change font size
Print view
FAQ
Register
Login

"Tribal Creature of the Sky" (Help appreciated) My 1st game
Post a reply

3 posts • Page 1 of 1

"Tribal Creature of the Sky" (Help appreciated) My 1st game
by Destructavator » Fri Mar 08, 2013 5:44 am
OK, after tinkering around with programming and 3D stuff, and helping with existing open-source projects,
I've decided to get serious about getting my 1st game going, and by that I mean my first "real" one that I'm
serious about eventually developing into something nice.
I admit I'm bad at picking cool game titles, but I ended up with "Tribal Creature of the Sky" for my project,
which is GPL open-source and newly registered on SourceForge:
https://sourceforge.net/projects/tribalcreature/
https://sourceforge.net/projects/tribalcreature/
This game is going to be a third-person type of shooter but will also have a strong plot (eventually), and will
involve more than just basic combat, but also role-playing elements and choices, possibly something like
Deus Ex (I admit I only played the first one, a long time ago). The main character himself is young, a native
being of the new world the game takes place in, and is much like a human but with feathered wings, fangs,
and retractable claws. This game will feature magic and spells, but also selected technology, so it will be a
blend of fantasy and shooting monsters with assault rifles and grenade launchers.
9/6/2019, 4:03 PM

Irrlicht Engine • View topic - "Tribal Creature of the Sky" (Help apprecia...

2 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=6&t=48321

It is going to be cross platform, aiming for all three major ones (Windows, Linux, Mac).
The project currently has the most up-to-date stuff in the SVN repo. I also enabled a Git repo, which is empty
right now - In my experience I work best and fastest with SVN - which gives me the least headaches - but if
other people volunteer to help I'll move things over to the Git system to manage things better.
A few screenshots (older ones are on SourceForge):
Image
Image
Image
Image
This project is really in its infancy, so it isn't jaw-dropping impressive, at least not yet, but I'd appreciate any
feedback or help from anyone interested in trying the "game preview" mode of the worldgen utility used to
generate each campaign game world. The demo preview currently allows one to fly, walk, run, and swim
around a generated terrain environment. Yes, I know it looks simple right now, perhaps even chintzy to some
of you who are used to the big AAA games, but over time I'm hoping to make it into something good.
Currently there are .exe files for Windows 32 and 64 bits, Linux and Mac will come later. The only other
library used is SFML for audio and a few minor other things. All the graphics are being done via OpenGL
with Irrlicht.
P.S. There is a readme.txt with a starting storyline and background included in the repo and snapshot
downloads.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

Re: "Tribal Creature of the Sky"
by Destructavator » Thu May 09, 2013 12:28 pm
I've made some progress on my project since the initial announcement, there is now a playable demo where
the player can operate a few weapons, fire projectiles, land in and take off from tree branches, swim in water,
and a few other things.
The "worldgen" application is no longer - I've been integrating everything into the main program now, which
has a more friendly menu.

9/6/2019, 4:03 PM

Irrlicht Engine • View topic - "Tribal Creature of the Sky" (Help apprecia...

3 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=6&t=48321

Also featured are config screens, including a customizable keymap that shows what keys do what.
I've put a lot of work into optimizations and ways of rendering large terrain sections with numerous objects
placed on the landscape, without slowing things down too much. Both the landscape and all terrain is
randomly generated from player-customizable seed values.
A few basic sound FX have been added.
The terrain overall looks nicer now, too. Here are a few recent screen shots, some which show the trees on the
map (note: Every single tree is custom generated, so no two trees are alike!):
Image
Image
Image
Image
Image
Image
Image
For those who don't want to bother with an SVN checkout and compile, you can download pre-built EXE
files for Windows in a demo that runs out-of-the-box, with executable files for both 32 and 64 bit Windows.
The downloads are on the Sourceforge project page.
Linux users: I'm soon going to be working on a makefile for the project, how soon it is ready depends on how
many issues and hurdles I find I have to overcome in getting it together and working properly. (I have custom
written makefiles before for other projects, so it isn't totally new to me.)
Again, if anyone wants to join the project, please let me know. At this point I can use contributions of almost
any kind, from sound FX to music, to 2D and/or 3D artwork, to coding, porting, lots of stuff. Or, you can all
sit back and watch as I continue to make it all by myself, but if that continues I want you to realize that as I
progress there will be gradually less and less room for you to add your own ideas if you come up with any.
(Although, given, the project IS licensed under GPL, so you could still make a mod or something of it.)
Note: I welcome help and contributions from people of nearly any skill level. No resume is required. You
also don't have to contribute full-time, either, if you come and go from the project that's fine. Speaking for
myself, I work on this in my spare time, which fluctuates all over the place.
EDIT: Added one more pic to show one of the weapons in action.
---"Destructavator" Dave: Developer of OS GPL VST "ScorchCrafter" Audio Plug-ins, contributer to UFO AI,
Day Job: Guitar Luthier (Customize musical instruments, repainting w/ custom artwork, graphics, logos,
decals, etc.)
User avatar
Destructavator
Posts: 40
Joined: Sat Feb 06, 2010 9:00 pm
Location: Ohio, USA
Top

9/6/2019, 4:03 PM

Irrlicht Engine • View topic - "Tribal Creature of the Sky" (Help apprecia...

4 of 4

http://irrlicht.sourceforge.net/forum/viewtopic.php?f=6&t=48321

Re: "Tribal Creature of the Sky" (Help appreciated) My 1st g
by rubenwardy » Tue May 14, 2013 10:26 am
Looks nice.
What is the aim of the game?
http://www.multa.bugs3.com/

rubenwardy
Posts: 91
Joined: Mon Mar 05, 2012 4:51 pm
Location: Bristol, UK
Website
Top
Display posts from previous:

Sort by

Post a reply
3 posts • Page 1 of 1
Return to Project Announcements
Jump to:

Who is online
Users browsing this forum: No registered users and 1 guest
Board index
The team • Delete all board cookies • All times are UTC
Powered by phpBB® Forum Software © phpBB Group

9/6/2019, 4:03 PM

