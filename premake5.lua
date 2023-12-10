
VULKAN_SDK_ENVVAR = {
   "VULKAN_SDK",
   "VK_SDK_PATH"
}

VULKAN_SDK = Solution.GetEnvironementVariable("VULKAN_SDK", VULKAN_SDK_ENVVAR);

outputdir = Solution.Path.OutputDirectory

Solution.Projects["Walnut"].PlatformDefineName = "WL"
Solution.Projects["Walnut"].Type = "StaticLib"
Solution.Projects["Walnut"].IncludeDirs = {
   "%{Solution.Projects.Walnut.Path}/%{VULKAN_SDK}/Include",
   "%{Solution.Projects.Walnut.Path}/vendor/glm",
   "%{Solution.Projects.Walnut.Path}/vendor/imgui",
   "%{Solution.Projects.Walnut.Path}/vendor/glfw/include",
   "%{Solution.Projects.Walnut.Path}/vendor/stb_image",
   "%{Solution.Projects.Walnut.Path}/src"
}

Solution.AddProject("GLFW", "vendor/GLFW/")
Solution.AddProject("ImGui", "vendor/imgui/")
Solution.Projects["GLFW"].Type = "StaticLib"
Solution.Projects["ImGui"].Type = "StaticLib"

group "Dependencies"
   Solution.PremakeIncludeProject("GLFW")
   Solution.PremakeIncludeProject("ImGui")
group ""

project "Walnut"
   kind 		   (Solution.Projects["Walnut"].Type)
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

	Solution.Project("Walnut")
