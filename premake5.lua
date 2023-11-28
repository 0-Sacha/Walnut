
Solution.ProjectEnvVar["VULKAN_SDK"] = {
   "VULKAN_SDK",
   "VK_SDK_PATH"
}
 
VULKAN_SDK = Solution.GetEnvironementVariable("VULKAN_SDK");

outputdir = Solution.Path.OutputDirectory

Solution.ProjectsInfo.IncludeDirs["Walnut"] = {
   "%{Solution.Projects.Walnut}/%{VULKAN_SDK}/Include",
   "%{Solution.Projects.Walnut}/vendor/glm",
   "%{Solution.Projects.Walnut}/vendor/imgui",
   "%{Solution.Projects.Walnut}/vendor/glfw/include",
   "%{Solution.Projects.Walnut}/vendor/stb_image",
   "%{Solution.Projects.Walnut}/src"
}

Solution.ProjectsInfo.PlatformDefineName["Walnut"] = "WL"

Solution.Projects["GLFW"] 	   = "vendor/GLFW"
Solution.Projects["ImGui"] 	= "vendor/imgui"

group "Dependencies"
	include (Solution.Projects["GLFW"])
	include (Solution.Projects["ImGui"])
group ""

project "Walnut"
   kind "StaticLib"
   language "C++"
   cppdialect "C++20"
   staticruntime "off"

   targetdir 	(Solution.Path.ProjectTargetDirectory)
   objdir 		(Solution.Path.ProjectObjectDirectory)

   files { "src/**.h", "src/**.cpp" }

   links {
      "ImGui",
      "GLFW",
      "%{VULKAN_SDK}/Lib/vulkan-1.lib"
   }

	Solution.IncludeProject("Walnut")